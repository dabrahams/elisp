;;; tramp-gvfs.el --- Tramp access functions for GVFS daemon

;; Copyright (C) 2009 Free Software Foundation, Inc.

;; Author: Michael Albinus <michael.albinus@gmx.de>
;; Keywords: comm, processes

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Access functions for the GVFS daemon from Tramp.  Tested with GVFS
;; 1.0.2 (Ubuntu 8.10, Gnome 2.24).

;; All actions to mount a remote location, and to retrieve mount
;; information, are performed by D-Bus messages.  File operations
;; themselves are performed via the mounted filesystem in ~/.gvfs.
;; Consequently, GNU Emacs 23.0.90 with enabled D-Bus bindings is a
;; precondition.

;; The GVFS D-Bus interface is said to be instable.  There are even no
;; introspection data.  The interface, as discovered during
;; development time, is given in respective comments.

;; The customer option `tramp-gvfs-methods' contains the list of
;; supported connection methods.  Per default, these are "dav", "davs"
;; and "obex".  Note that with "obex" it might be necessary to pair
;; with the other bluetooth device, if it hasn't been done already.
;; There might be also some few seconds delay in discovering available
;; bluetooth devices.

;; Other possible connection methods are "ftp", "sftp" and "smb".
;; When one of these methods is added to the list, the remote access
;; for that method is performed via GVFS instead of the native Tramp
;; implementation.

;; GVFS offers even more connection methods.  The complete list of
;; connection methods of the actual GVFS implementation can be
;; retrieved by:
;;
;; (message
;;  "%s"
;;  (mapcar
;;   'car
;;   (dbus-call-method
;;    :session tramp-gvfs-service-daemon tramp-gvfs-path-mounttracker
;;    tramp-gvfs-interface-mounttracker "listMountableInfo")))

;; Note that all other connection methods are not tested, beside the
;; ones offered for customization in `tramp-gvfs-methods'.  If you
;; request an additional connection method to be supported, please
;; drop me a note.

;; For hostname completion, information is retrieved either from the
;; bluez daemon (for the "obex" method), or from the zeroconf daemon
;; (for the "dav", "davs", and "sftp" methods).  The zeroconf daemon
;; is pre-configured to discover services in the "local" domain.  If
;; another domain shall be used for discovering services, the customer
;; option `tramp-gvfs-zeroconf-domain' can be set accordingly.

;; Restrictions:

;; * The current GVFS implementation does not allow to write on the
;;   remote bluetooth device via OBEX.
;;
;; * Two shares of the same SMB server cannot be mounted in parallel.

;;; Code:

(require 'cl)
(require 'dbus)
(require 'tramp)
(require 'url-parse)
(require 'zeroconf)

(defcustom tramp-gvfs-methods '("dav" "davs" "obex")
  "*List of methods for remote files, accessed with GVFS."
  :group 'tramp
  :type '(repeat (choice (const "dav")
			 (const "davs")
			 (const "ftp")
			 (const "obex")
			 (const "sftp")
			 (const "smb"))))

(defcustom tramp-gvfs-zeroconf-domain "local"
  "*Zeroconf domain to be used for discovering services, like host names."
  :group 'tramp
  :type 'string)

;; Add the methods to `tramp-methods', in order to allow minibuffer
;; completion.
(eval-after-load "tramp-gvfs"
  '(when (featurep 'tramp-gvfs)
     (dolist (elt tramp-gvfs-methods)
       (unless (assoc elt tramp-methods)
	 (add-to-list 'tramp-methods (cons elt nil))))))

(defconst tramp-gvfs-mount-point
  (file-name-as-directory (expand-file-name ".gvfs" "~/"))
  "The directory name, fuses mounts remote ressources.")

(defconst tramp-gvfs-path-tramp (concat dbus-path-emacs "/Tramp")
  "The preceeding object path for own objects.")

(defconst tramp-gvfs-service-daemon "org.gtk.vfs.Daemon"
  "The well known name of the GVFS daemon.")

;; Check that GVFS is available.
(unless (dbus-ping :session tramp-gvfs-service-daemon)
  (message "GVFS daemon not running")
  (throw 'tramp-loading nil))

(defconst tramp-gvfs-path-mounttracker "/org/gtk/vfs/mounttracker"
  "The object path of the GVFS daemon.")

(defconst tramp-gvfs-interface-mounttracker "org.gtk.vfs.MountTracker"
  "The mount tracking interface in the GVFS daemon.")

;; <interface name='org.gtk.vfs.MountTracker'>
;;   <method name='listMounts'>
;;     <arg name='mount_info_list'
;;          type='a{sosssssbay{aya{say}}}'
;;          direction='out'/>
;;   </method>
;;   <method name='mountLocation'>
;;     <arg name='mount_spec'  type='{aya{say}}' direction='in'/>
;;     <arg name='dbus_id'     type='s'          direction='in'/>
;;     <arg name='object_path' type='o'          direction='in'/>
;;   </method>
;;   <signal name='mounted'>
;;     <arg name='mount_info'
;;          type='{sosssssbay{aya{say}}}'/>
;;   </signal>
;;   <signal name='unmounted'>
;;     <arg name='mount_info'
;;          type='{sosssssbay{aya{say}}}'/>
;;   </signal>
;; </interface>
;;
;; STRUCT		mount_info
;;   STRING		  dbus_id
;;   OBJECT_PATH	  object_path
;;   STRING		  display_name
;;   STRING		  stable_name
;;   STRING		  x_content_types
;;   STRING		  icon
;;   STRING		  prefered_filename_encoding
;;   BOOLEAN		  user_visible
;;   ARRAY BYTE		  fuse_mountpoint
;;   STRUCT		  mount_spec
;;     ARRAY BYTE	    mount_prefix
;;     ARRAY
;;       STRUCT		    mount_spec_item
;;         STRING	      key (server, share, type, user, host, port)
;;         ARRAY BYTE	      value

(defconst tramp-gvfs-interface-mountoperation "org.gtk.vfs.MountOperation"
  "Used by the dbus-proxying implementation of GMountOperation.")

;; <interface name='org.gtk.vfs.MountOperation'>
;;   <method name='askPassword'>
;;     <arg name='message' type='s'  direction='in'/>
;;     <arg name='default_user'   type='s' direction='in'/>
;;     <arg name='default_domain' type='s' direction='in'/>
;;     <arg name='flags'          type='u' direction='in'/>
;;     <arg name='handled'        type='b' direction='out'/>
;;     <arg name='aborted'        type='b' direction='out'/>
;;     <arg name='password'       type='s' direction='out'/>
;;     <arg name='username'       type='s' direction='out'/>
;;     <arg name='domain'         type='s' direction='out'/>
;;     <arg name='anonymous'      type='b' direction='out'/>
;;     <arg name='password_save'  type='u' direction='out'/>
;;   </method>
;;   <method name='askQuestion'>
;;     <arg name='message' type='s'  direction='in'/>
;;     <arg name='choices' type='as' direction='in'/>
;;     <arg name='handled' type='b'  direction='out'/>
;;     <arg name='aborted' type='b'  direction='out'/>
;;     <arg name='choice'  type='u'  direction='out'/>
;;   </method>
;; </interface>

;; The following flags are used in "askPassword".  They are defined in
;; /usr/include/glib-2.0/gio/gioenums.h.

(defconst tramp-gvfs-password-need-password 1
  "Operation requires a password.")

(defconst tramp-gvfs-password-need-username 2
  "Operation requires a username.")

(defconst tramp-gvfs-password-need-domain 4
  "Operation requires a domain.")

(defconst tramp-gvfs-password-saving-supported 8
  "Operation supports saving settings.")

(defconst tramp-gvfs-password-anonymous-supported 16
  "Operation supports anonymous users.")

(defconst tramp-bluez-service "org.bluez"
  "The well known name of the BLUEZ service.")

(defconst tramp-bluez-interface-manager "org.bluez.Manager"
  "The manager interface of the BLUEZ daemon.")

;; <interface name='org.bluez.Manager'>
;;   <method name='DefaultAdapter'>
;;     <arg type='o' direction='out'/>
;;   </method>
;;   <method name='FindAdapter'>
;;     <arg type='s' direction='in'/>
;;     <arg type='o' direction='out'/>
;;   </method>
;;   <method name='ListAdapters'>
;;     <arg type='ao' direction='out'/>
;;   </method>
;;   <signal name='AdapterAdded'>
;;     <arg type='o'/>
;;   </signal>
;;   <signal name='AdapterRemoved'>
;;     <arg type='o'/>
;;   </signal>
;;   <signal name='DefaultAdapterChanged'>
;;     <arg type='o'/>
;;   </signal>
;; </interface>

(defconst tramp-bluez-interface-adapter "org.bluez.Adapter"
  "The adapter interface of the BLUEZ daemon.")

;; <interface name='org.bluez.Adapter'>
;;   <method name='GetProperties'>
;;     <arg type='a{sv}' direction='out'/>
;;   </method>
;;   <method name='SetProperty'>
;;     <arg type='s' direction='in'/>
;;     <arg type='v' direction='in'/>
;;   </method>
;;   <method name='RequestMode'>
;;     <arg type='s' direction='in'/>
;;   </method>
;;   <method name='ReleaseMode'/>
;;   <method name='RequestSession'/>
;;   <method name='ReleaseSession'/>
;;   <method name='StartDiscovery'/>
;;   <method name='StopDiscovery'/>
;;   <method name='ListDevices'>
;;     <arg type='ao' direction='out'/>
;;   </method>
;;   <method name='CreateDevice'>
;;     <arg type='s' direction='in'/>
;;     <arg type='o' direction='out'/>
;;   </method>
;;   <method name='CreatePairedDevice'>
;;     <arg type='s' direction='in'/>
;;     <arg type='o' direction='in'/>
;;     <arg type='s' direction='in'/>
;;     <arg type='o' direction='out'/>
;;   </method>
;;   <method name='CancelDeviceCreation'>
;;     <arg type='s' direction='in'/>
;;   </method>
;;   <method name='RemoveDevice'>
;;     <arg type='o' direction='in'/>
;;   </method>
;;   <method name='FindDevice'>
;;     <arg type='s' direction='in'/>
;;     <arg type='o' direction='out'/>
;;   </method>
;;   <method name='RegisterAgent'>
;;     <arg type='o' direction='in'/>
;;     <arg type='s' direction='in'/>
;;   </method>
;;   <method name='UnregisterAgent'>
;;     <arg type='o' direction='in'/>
;;   </method>
;;   <signal name='DeviceCreated'>
;;     <arg type='o'/>
;;   </signal>
;;   <signal name='DeviceRemoved'>
;;     <arg type='o'/>
;;   </signal>
;;   <signal name='DeviceFound'>
;;     <arg type='s'/>
;;     <arg type='a{sv}'/>
;;   </signal>
;;   <signal name='PropertyChanged'>
;;     <arg type='s'/>
;;     <arg type='v'/>
;;   </signal>
;;   <signal name='DeviceDisappeared'>
;;     <arg type='s'/>
;;   </signal>
;; </interface>

(defcustom tramp-bluez-discover-devices-timeout 60
  "Defines seconds since last bluetooth device discovery before rescanning.
A value of 0 would require an immediate discovery during hostname
completion, nil means to use always cached values for discovered
devices."
  :group 'tramp
  :type '(choice (const nil) integer))

(defvar tramp-bluez-discovery nil
  "Indicator for a running bluetooth device discovery.
It keeps the timestamp of last discovery.")

(defvar tramp-bluez-devices nil
  "Alist of detected bluetooth devices.
Every entry is a list (NAME ADDRESS).")

;; New handlers should be added here.
(defconst tramp-gvfs-file-name-handler-alist
  '(
    (access-file . ignore)
    (add-name-to-file . tramp-gvfs-handle-copy-file)
    ;; `byte-compiler-base-file-name' performed by default handler
    (copy-file . tramp-gvfs-handle-copy-file)
    (delete-directory . tramp-gvfs-handle-delete-directory)
    (delete-file . tramp-gvfs-handle-delete-file)
    ;; `diff-latest-backup-file' performed by default handler
    (directory-file-name . tramp-handle-directory-file-name)
    (directory-files . tramp-gvfs-handle-directory-files)
    (directory-files-and-attributes
     . tramp-gvfs-handle-directory-files-and-attributes)
    (dired-call-process . ignore)
    (dired-compress-file . ignore)
    ;; `dired-uncache' performed by default handler
    (expand-file-name . tramp-gvfs-handle-expand-file-name)
    ;; `file-accessible-directory-p' performed by default handler
    (file-attributes . tramp-gvfs-handle-file-attributes)
    (file-directory-p . tramp-smb-handle-file-directory-p)
    (file-executable-p . tramp-gvfs-handle-file-executable-p)
    (file-exists-p . tramp-gvfs-handle-file-exists-p)
    (file-local-copy . tramp-gvfs-handle-file-local-copy)
    (file-remote-p . tramp-handle-file-remote-p)
    ;; `file-modes' performed by default handler
    (file-name-all-completions . tramp-gvfs-handle-file-name-all-completions)
    (file-name-as-directory . tramp-handle-file-name-as-directory)
    (file-name-completion . tramp-handle-file-name-completion)
    (file-name-directory . tramp-handle-file-name-directory)
    (file-name-nondirectory . tramp-handle-file-name-nondirectory)
    ;; `file-name-sans-versions' performed by default handler
    (file-newer-than-file-p . tramp-handle-file-newer-than-file-p)
    (file-ownership-preserved-p . ignore)
    (file-readable-p . tramp-gvfs-handle-file-readable-p)
    (file-regular-p . tramp-handle-file-regular-p)
    (file-symlink-p . tramp-handle-file-symlink-p)
    ;; `file-truename' performed by default handler
    (file-writable-p . tramp-gvfs-handle-file-writable-p)
    (find-backup-file-name . tramp-handle-find-backup-file-name)
    ;; `find-file-noselect' performed by default handler
    ;; `get-file-buffer' performed by default handler
    (insert-directory . tramp-gvfs-handle-insert-directory)
    (insert-file-contents . tramp-gvfs-handle-insert-file-contents)
    (load . tramp-handle-load)
    (make-directory . tramp-gvfs-handle-make-directory)
    (make-directory-internal . ignore)
    (make-symbolic-link . ignore)
    (rename-file . tramp-gvfs-handle-rename-file)
    (set-file-modes . tramp-gvfs-handle-set-file-modes)
    (set-visited-file-modtime . tramp-gvfs-handle-set-visited-file-modtime)
    (shell-command . ignore)
    (substitute-in-file-name . tramp-handle-substitute-in-file-name)
    (unhandled-file-name-directory . tramp-handle-unhandled-file-name-directory)
    (vc-registered . ignore)
    (verify-visited-file-modtime
     . tramp-gvfs-handle-verify-visited-file-modtime)
    (write-region . tramp-gvfs-handle-write-region)
)
  "Alist of handler functions for Tramp GVFS method.
Operations not mentioned here will be handled by the default Emacs primitives.")

(defun tramp-gvfs-file-name-p (filename)
  "Check if it's a filename handled by the GVFS daemon."
  (and (tramp-tramp-file-p filename)
       (let ((method
	      (tramp-file-name-method (tramp-dissect-file-name filename))))
	 (and (stringp method) (member method tramp-gvfs-methods)))))

(defun tramp-gvfs-file-name-handler (operation &rest args)
  "Invoke the GVFS related OPERATION.
First arg specifies the OPERATION, second arg is a list of arguments to
pass to the OPERATION."
  (let ((fn (assoc operation tramp-gvfs-file-name-handler-alist)))
    (if fn
	(save-match-data (apply (cdr fn) args))
      (tramp-run-real-handler operation args))))

;; This might be moved to tramp.el.  It shall be the first file name
;; handler.
(add-to-list 'tramp-foreign-file-name-handler-alist
	     (cons 'tramp-gvfs-file-name-p 'tramp-gvfs-file-name-handler))

(defmacro with-tramp-dbus-call-method
  (vec synchronous bus service path interface method &rest args)
  "Apply a D-Bus call on bus BUS.

If SYNCHRONOUS is non-nil, the call is synchronously.  Otherwise,
it is an asynchronous call, with `ignore' as callback function.

The other arguments have the same meaning as with `dbus-call-method'
or `dbus-call-method-asynchronously'.  Additionally, the call
will be traced by Tramp with trace level 6."
  `(let ((func (if ,synchronous
		   'dbus-call-method 'dbus-call-method-asynchronously))
	 (args (append (list ,bus ,service ,path ,interface ,method)
		       (if ,synchronous (list ,@args) (list 'ignore ,@args))))
	 result)
     (tramp-message ,vec 6 "%s %s" func args)
     (setq result (apply func args))
     (tramp-message ,vec 6 "\n%s" result)
     result))

(put 'with-tramp-dbus-call-method 'lisp-indent-function 2)
(put 'with-tramp-dbus-call-method 'edebug-form-spec '(form symbolp body))
(font-lock-add-keywords 'emacs-lisp-mode '("\\<with-tramp-dbus-call-method\\>"))

(defmacro with-tramp-gvfs-error-message (filename handler &rest args)
  "Apply a Tramp GVFS `handler'.
In case of an error, modify the error message by replacing
`filename' with its GVFS mounted name."
  `(let ((fuse-file-name  (regexp-quote (tramp-gvfs-fuse-file-name ,filename)))
	 elt)
     (condition-case err
	 (apply ,handler (list ,@args))
       (error
	(setq elt (cdr err))
	(while elt
	  (when (and (stringp (car elt))
		     (string-match fuse-file-name (car elt)))
	    (setcar elt (replace-match ,filename t t (car elt))))
	  (setq elt (cdr elt)))
	(signal (car err) (cdr err))))))

(put 'with-tramp-gvfs-error-message 'lisp-indent-function 2)
(put 'with-tramp-gvfs-error-message 'edebug-form-spec '(form symbolp body))
(font-lock-add-keywords 'emacs-lisp-mode '("\\<with-tramp-gvfs-error-message\\>"))

(defvar tramp-gvfs-dbus-event-vector nil
  "Current Tramp file name to be used, as vector.
It is needed when D-Bus signals or errors arrive, because there
is no information where to trace the message.")

(defun tramp-gvfs-dbus-event-error (event err)
  "Called when a D-Bus error message arrives, see `dbus-event-error-hooks'."
;  (tramp-cleanup-connection tramp-gvfs-dbus-event-vector)
  (tramp-message tramp-gvfs-dbus-event-vector 1 "%S" event)
  (tramp-error tramp-gvfs-dbus-event-vector 'file-error "%s" (cadr err)))

(add-hook 'dbus-event-error-hooks 'tramp-gvfs-dbus-event-error)


;; File name primitives.

(defun tramp-gvfs-handle-copy-file
  (filename newname &optional ok-if-already-exists keep-date preserve-uid-gid)
  "Like `copy-file' for Tramp files."
  (copy-file
   (if (tramp-gvfs-file-name-p filename)
       (tramp-gvfs-fuse-file-name filename)
     filename)
   (if (tramp-gvfs-file-name-p newname)
       (tramp-gvfs-fuse-file-name newname)
     newname)
   ok-if-already-exists keep-date preserve-uid-gid))

(defun tramp-gvfs-handle-delete-directory (directory)
  "Like `delete-directory' for Tramp files."
  (delete-directory (tramp-gvfs-fuse-file-name directory)))

(defun tramp-gvfs-handle-delete-file (filename)
  "Like `delete-file' for Tramp files."
  (delete-file (tramp-gvfs-fuse-file-name filename)))

(defun tramp-gvfs-handle-directory-files
  (directory &optional full match nosort)
  "Like `directory-files' for Tramp files."
  (let ((fuse-file-name (tramp-gvfs-fuse-file-name directory)))
    (mapcar
     (lambda (x)
       (if (string-match fuse-file-name x)
	   (replace-match directory t t x)
	 x))
     (directory-files fuse-file-name full match nosort))))

(defun tramp-gvfs-handle-directory-files-and-attributes
  (directory &optional full match nosort id-format)
  "Like `directory-files-and-attributes' for Tramp files."
  (let ((fuse-file-name (tramp-gvfs-fuse-file-name directory)))
    (mapcar
     (lambda (x)
       (when (string-match fuse-file-name (car x))
	 (setcar x (replace-match directory t t (car x))))
       x)
     (directory-files-and-attributes
      fuse-file-name full match nosort id-format))))

(defun tramp-gvfs-handle-expand-file-name (name &optional dir)
  "Like `expand-file-name' for Tramp files."
  ;; If DIR is not given, use DEFAULT-DIRECTORY or "/".
  (setq dir (or dir default-directory "/"))
  ;; Unless NAME is absolute, concat DIR and NAME.
  (unless (file-name-absolute-p name)
    (setq name (concat (file-name-as-directory dir) name)))
  ;; If NAME is not a Tramp file, run the real handler.
  (if (not (tramp-tramp-file-p name))
      (tramp-run-real-handler 'expand-file-name (list name nil))
    ;; Dissect NAME.
    (with-parsed-tramp-file-name name nil
      ;; Tilde expansion is not possible.
      (when (string-match "\\`\\(~[^/]*\\)\\(.*\\)\\'" localname)
	(tramp-error
	 v 'file-error
	 "Cannot expand tilde in file `%s'" name))
      (unless (tramp-run-real-handler 'file-name-absolute-p (list localname))
	(setq localname (concat "/" localname)))
      ;; We do not pass "/..".
      (if (string-equal "smb" method)
	  (when (string-match "^/[^/]+\\(/\\.\\./?\\)" localname)
	    (setq localname (replace-match "/" t t localname 1)))
	(when (string-match "^/\\.\\./?" localname)
	  (setq localname (replace-match "/" t t localname))))
      ;; There might be a double slash.  Remove this.
      (while (string-match "//" localname)
	(setq localname (replace-match "/" t t localname)))
      ;; No tilde characters in file name, do normal
      ;; `expand-file-name' (this does "/./" and "/../").
      (tramp-make-tramp-file-name
       method user host
       (tramp-run-real-handler
	'expand-file-name (list localname))))))

(defun tramp-gvfs-handle-file-attributes (filename &optional id-format)
  "Like `file-attributes' for Tramp files."
  (file-attributes (tramp-gvfs-fuse-file-name filename) id-format))

(defun tramp-gvfs-handle-file-executable-p (filename)
  "Like `file-executable-p' for Tramp files."
  (file-executable-p (tramp-gvfs-fuse-file-name filename)))

(defun tramp-gvfs-handle-file-exists-p (filename)
  "Like `file-exists-p' for Tramp files."
  (file-exists-p (tramp-gvfs-fuse-file-name filename)))

(defun tramp-gvfs-handle-file-local-copy (filename)
  "Like `file-local-copy' for Tramp files."
  (with-parsed-tramp-file-name filename nil
    (let ((tmpfile (tramp-compat-make-temp-file filename)))
      (unless (file-exists-p filename)
	(tramp-error
	 v 'file-error
	 "Cannot make local copy of non-existing file `%s'" filename))
      (copy-file filename tmpfile t t)
      tmpfile)))

(defun tramp-gvfs-handle-file-name-all-completions (filename directory)
  "Like `file-name-all-completions' for Tramp files."
  (unless (save-match-data (string-match "/" filename))
    (file-name-all-completions filename (tramp-gvfs-fuse-file-name directory))))

(defun tramp-gvfs-handle-file-readable-p (filename)
  "Like `file-readable-p' for Tramp files."
  (file-readable-p (tramp-gvfs-fuse-file-name filename)))

(defun tramp-gvfs-handle-file-writable-p (filename)
  "Like `file-writable-p' for Tramp files."
  (file-writable-p (tramp-gvfs-fuse-file-name filename)))

(defun tramp-gvfs-handle-insert-directory
  (filename switches &optional wildcard full-directory-p)
  "Like `insert-directory' for Tramp files."
  (insert-directory
   (tramp-gvfs-fuse-file-name filename) switches wildcard full-directory-p))

(defun tramp-gvfs-handle-insert-file-contents
  (filename &optional visit beg end replace)
  "Like `insert-file-contents' for Tramp files."
  (unwind-protect
      (let ((fuse-file-name (tramp-gvfs-fuse-file-name filename))
	    (result
	     (insert-file-contents
	      (tramp-gvfs-fuse-file-name filename) visit beg end replace)))
	(when (string-match fuse-file-name (car result))
	  (setcar result (replace-match filename t t (car result))))
	result)
    (setq buffer-file-name filename)))

(defun tramp-gvfs-handle-make-directory (dir &optional parents)
  "Like `make-directory' for Tramp files."
  (condition-case err
      (with-tramp-gvfs-error-message dir 'make-directory
	(tramp-gvfs-fuse-file-name dir) parents)
    ;; Error case.  Let's try it with the GVFS utilities.
    (error
     (with-parsed-tramp-file-name filename nil
       (tramp-message v 4 "`make-directory' failed, trying `gvfs-mkdir'")
       (unless
	   (zerop
	    (tramp-local-call-process
	     "gvfs-mkdir" nil (tramp-get-buffer v) nil
	     (tramp-gvfs-url-file-name filename)))
	 (signal (car err) (cdr err)))))))

(defun tramp-gvfs-handle-rename-file
  (filename newname &optional ok-if-already-exists)
  "Like `rename-file' for Tramp files."
  (rename-file
   (if (tramp-gvfs-file-name-p filename)
       (tramp-gvfs-fuse-file-name filename)
     filename)
   (if (tramp-gvfs-file-name-p newname)
       (tramp-gvfs-fuse-file-name newname)
     newname)
   ok-if-already-exists))

(defun tramp-gvfs-handle-set-file-modes (filename mode)
  "Like `set-file-modes' for Tramp files."
  (with-tramp-gvfs-error-message filename 'set-file-modes
    (tramp-gvfs-fuse-file-name filename) mode))

(defun tramp-gvfs-handle-set-visited-file-modtime (&optional time-list)
  "Like `set-visited-file-modtime' for Tramp files."
  (let ((buffer-file-name (tramp-gvfs-fuse-file-name (buffer-file-name))))
    (set-visited-file-modtime time-list)))

(defun tramp-gvfs-handle-verify-visited-file-modtime (buf)
  "Like `verify-visited-file-modtime' for Tramp files."
  (with-current-buffer buf
    (let ((buffer-file-name (tramp-gvfs-fuse-file-name (buffer-file-name))))
      (verify-visited-file-modtime buf))))

(defun tramp-gvfs-handle-write-region
  (start end filename &optional append visit lockname confirm)
  "Like `write-region' for Tramp files."
  (with-parsed-tramp-file-name filename nil
    (condition-case err
	(with-tramp-gvfs-error-message filename 'write-region
	  start end (tramp-gvfs-fuse-file-name filename)
	  append visit lockname confirm)

      ;; Error case.  Let's try it with the GVFS utilities.
      (error
       (let ((tmpfile (tramp-compat-make-temp-file filename)))
	 (tramp-message v 4 "`write-region' failed, trying `gvfs-save'")
	 (write-region start end tmpfile)
	 (unwind-protect
	     (unless
		 (zerop
		  (tramp-local-call-process
		   "gvfs-save" tmpfile (tramp-get-buffer v) nil
		   (tramp-gvfs-url-file-name filename)))
	       (signal (car err) (cdr err)))
	   (delete-file tmpfile)))))

    ;; The end.
    (when (or (eq visit t) (null visit) (stringp visit))
      (tramp-message v 0 "Wrote %s" filename))
    (run-hooks 'tramp-handle-write-region-hook)))


;; File name conversions.

(defun tramp-gvfs-url-file-name (filename)
  "Return FILENAME in URL syntax."
  (url-recreate-url
   (if (tramp-tramp-file-p filename)
       (with-parsed-tramp-file-name (file-truename filename) nil
	 (when (string-match tramp-user-with-domain-regexp user)
	   (setq user
		 (concat (match-string 2 user) ";"  (match-string 2 user))))
	 (url-parse-make-urlobj
	  method user nil
	  (tramp-file-name-real-host v) (tramp-file-name-port v) localname))
     (url-parse-make-urlobj "file" nil nil nil nil (file-truename filename)))))

(defun tramp-gvfs-object-path (filename)
  "Create a D-Bus object path from FILENAME."
  (expand-file-name (dbus-escape-as-identifier filename) tramp-gvfs-path-tramp))

(defun tramp-gvfs-file-name (object-path)
  "Retrieve file name from D-Bus OBJECT-PATH."
  (dbus-unescape-from-identifier
   (replace-regexp-in-string "^.*/\\([^/]+\\)$" "\\1" object-path)))

(defun tramp-gvfs-fuse-file-name (filename)
  "Return FUSE file name, which is directly accessible."
  (with-parsed-tramp-file-name (expand-file-name filename) nil
    (tramp-gvfs-maybe-open-connection v)
    (let ((fuse-mountpoint
	   (tramp-get-file-property v "/" "fuse-mountpoint" nil)))
      (unless fuse-mountpoint
	(tramp-error
	 v 'file-error "There is no FUSE mount point for `%s'" filename))
      ;; We must remove the share from the local name.
      (when (and (string-equal "smb" method) (string-match "/[^/]+" localname))
	(setq localname (replace-match "" t t localname)))
      (concat tramp-gvfs-mount-point fuse-mountpoint localname))))

(defun tramp-bluez-address (device)
  "Return bluetooth device address from a given bluetooth DEVICE name."
  (when (stringp device)
    (if (string-match tramp-ipv6-regexp device)
	(match-string 0 device)
      (cadr (assoc device (tramp-bluez-list-devices))))))

(defun tramp-bluez-device (address)
  "Return bluetooth device name from a given bluetooth device ADDRESS.
ADDRESS can have the form \"xx:xx:xx:xx:xx:xx\" or \"[xx:xx:xx:xx:xx:xx]\"."
  (when (stringp address)
    (while (string-match "[][]" address)
      (setq address (replace-match "" t t address)))
    (let (result)
      (dolist (item (tramp-bluez-list-devices) result)
	(when (string-match address (cadr item))
	  (setq result (car item)))))))


;; D-Bus GVFS functions.

(defun tramp-gvfs-handler-askpassword (message user domain flags)
  "Implementation for the \"org.gtk.vfs.MountOperation.askPassword\" method."
  (let* ((filename
	  (tramp-gvfs-file-name (dbus-event-path-name last-input-event)))
	 (pw-prompt
	  (format
	   "%s for %s "
	   (if (string-match "\\([pP]assword\\|[pP]assphrase\\)" message)
	       (capitalize (match-string 1 message))
	     "Password")
	   filename))
	 password)

    (condition-case nil
	(with-parsed-tramp-file-name filename nil
	  (when (and (zerop (length user))
		     (not
		      (zerop (logand flags tramp-gvfs-password-need-username))))
	    (setq user (read-string "User name: ")))
	  (when (and (zerop (length domain))
		     (not (zerop (logand flags tramp-gvfs-password-need-domain))))
	    (setq domain (read-string "Domain name: ")))

	  (tramp-message v 6 "%S %S %S %d" message user domain flags)
	  (setq tramp-current-method method
		tramp-current-user user
		tramp-current-host host
		password (tramp-read-passwd
			  (tramp-get-connection-process v) pw-prompt))

	  ;; Return result.
	  (if (stringp password)
	      (list
	       t ;; password handled.
	       nil ;; no abort of D-Bus.
	       password
	       (tramp-file-name-real-user v)
	       domain
	       nil ;; not anonymous.
	       0) ;; no password save.
	    ;; No password provided.
	    (list nil t "" (tramp-file-name-real-user v) domain nil 0)))

      ;; When QUIT is raised, we shall return this information to D-Bus.
      (quit (list nil t "" "" "" nil 0)))))

(defun tramp-gvfs-handler-askquestion (message choices)
  "Implementation for the \"org.gtk.vfs.MountOperation.askQuestion\" method."
  (save-window-excursion
    (let ((enable-recursive-minibuffers t)
	  choice)

      (condition-case nil
	  (with-parsed-tramp-file-name
	      (tramp-gvfs-file-name (dbus-event-path-name last-input-event)) nil
	    (tramp-message v 6 "%S %S" message choices)

	    ;; In theory, there can be several choices.  Until now,
	    ;; there is only the question whether to accept an unknown
	    ;; host signature.
	    (with-temp-buffer
	      (insert message)
	      (pop-to-buffer (current-buffer))
	      (setq choice (if (yes-or-no-p (concat (car choices) " ")) 0 1))
	      (tramp-message v 6 "%d" choice))

	    ;; When the choice is "no", we set an empty
	    ;; fuse-mountpoint in order to leave the timeout.
	    (unless (zerop choice)
	      (tramp-set-file-property v "/" "fuse-mountpoint" ""))

	    (list
	     t ;; handled.
	     nil ;; no abort of D-Bus.
	     choice))

	  ;; When QUIT is raised, we shall return this information to D-Bus.
	  (quit (list nil t 0))))))

(defun tramp-gvfs-handler-mounted-unmounted (mount-info)
  "Signal handler for the \"org.gtk.vfs.MountTracker.mounted\" and
\"org.gtk.vfs.MountTracker.unmounted\" signals."
  (ignore-errors
    (let* ((signal-name (dbus-event-member-name last-input-event))
	   (mount-spec (nth 1 (nth 9 mount-info)))
	   (method (dbus-byte-array-to-string (cadr (assoc "type" mount-spec))))
	   (user (dbus-byte-array-to-string (cadr (assoc "user" mount-spec))))
	   (domain (dbus-byte-array-to-string
		    (cadr (assoc "domain" mount-spec))))
	   (host (dbus-byte-array-to-string
		  (cadr (or (assoc "host" mount-spec)
			    (assoc "server" mount-spec)))))
	   (port (dbus-byte-array-to-string (cadr (assoc "port" mount-spec))))
	   (ssl (dbus-byte-array-to-string (cadr (assoc "ssl" mount-spec)))))
      (when (string-match "^smb" method)
	(setq method "smb"))
      (when (string-equal "obex" method)
	(setq host (tramp-bluez-device host)))
      (when (and (string-equal "dav" method) (string-equal "true" ssl))
	(setq method "davs"))
      (unless (zerop (length domain))
	(setq user (concat user tramp-prefix-domain-format domain)))
      (unless (zerop (length port))
	(setq host (concat host tramp-prefix-port-format port)))
      (with-parsed-tramp-file-name
	  (tramp-make-tramp-file-name method user host "") nil
	(tramp-message v 6 "%s %s" signal-name mount-info)
	(tramp-set-file-property v "/" "list-mounts" 'undef)
	(if (string-equal signal-name "unmounted")
	    (tramp-set-file-property v "/" "fuse-mountpoint" nil)
	  (tramp-set-file-property
	   v "/" "fuse-mountpoint"
	   (file-name-nondirectory
	    (dbus-byte-array-to-string (nth 8 mount-info)))))))))

(dbus-register-signal
 :session nil tramp-gvfs-path-mounttracker
 tramp-gvfs-interface-mounttracker "mounted"
 'tramp-gvfs-handler-mounted-unmounted)

(dbus-register-signal
 :session nil tramp-gvfs-path-mounttracker
 tramp-gvfs-interface-mounttracker "unmounted"
 'tramp-gvfs-handler-mounted-unmounted)

(defun tramp-gvfs-connection-mounted-p (vec)
  "Check, whether the location is already mounted."
  (catch 'mounted
    (dolist
	(elt
	 (with-file-property vec "/" "list-mounts"
	   (with-tramp-dbus-call-method vec t
	     :session tramp-gvfs-service-daemon tramp-gvfs-path-mounttracker
	     tramp-gvfs-interface-mounttracker "listMounts"))
	 nil)
      (let* ((mount-spec (nth 1 (nth 9 elt)))
	     (method (dbus-byte-array-to-string
		      (cadr (assoc "type" mount-spec))))
	     (user (dbus-byte-array-to-string
		    (cadr (assoc "user" mount-spec))))
	     (domain (dbus-byte-array-to-string
		      (cadr (assoc "domain" mount-spec))))
	     (host (dbus-byte-array-to-string
		    (cadr (or (assoc "host" mount-spec)
			      (assoc "server" mount-spec)))))
	     (port (dbus-byte-array-to-string (cadr (assoc "port" mount-spec))))
	     (ssl (dbus-byte-array-to-string (cadr (assoc "ssl" mount-spec)))))
	(when (string-match "^smb" method)
	  (setq method "smb"))
	(when (string-equal "obex" method)
	  (setq host (tramp-bluez-device host)))
	(when (and (string-equal "dav" method) (string-equal "true" ssl))
	  (setq method "davs"))
	(unless (zerop (length domain))
	  (setq user (concat user tramp-prefix-domain-format domain)))
	(unless (zerop (length port))
	  (setq host (concat host tramp-prefix-port-format port)))
	(when (and
	       (string-equal method (tramp-file-name-method vec))
	       (string-equal user (or (tramp-file-name-user vec) ""))
	       (string-equal host (tramp-file-name-host vec)))
	  (tramp-set-file-property
	   vec "/" "fuse-mountpoint"
	   (file-name-nondirectory (dbus-byte-array-to-string (nth 8 elt))))
	  (throw 'mounted t))))))

(defun tramp-gvfs-mount-spec (vec)
  "Return a mount-spec for \"org.gtk.vfs.MountTracker.mountLocation\"."
  (let* ((method (tramp-file-name-method vec))
	 (user (tramp-file-name-real-user vec))
	 (domain (tramp-file-name-domain vec))
	 (host (tramp-file-name-real-host vec))
	 (port (tramp-file-name-port vec))
	 (localname (tramp-file-name-localname vec))
	 (ssl (if (string-match "^davs" method) "true" "false"))
	 (mount-spec `(:array)))

    (setq
     mount-spec
     (append
      mount-spec
      (cond
       ((string-equal "smb" method)
	(string-match "^/?\\([^/]+\\)" localname)
	`((:struct "type" ,(dbus-string-to-byte-array "smb-share"))
	  (:struct "server" ,(dbus-string-to-byte-array host))
	  (:struct "share" ,(dbus-string-to-byte-array
			     (match-string 1 localname)))))
       ((string-equal "obex" method)
	`((:struct "type" ,(dbus-string-to-byte-array method))
	  (:struct "host" ,(dbus-string-to-byte-array
			    (concat "[" (tramp-bluez-address host) "]")))))
       ((string-match "^dav" method)
	`((:struct "type" ,(dbus-string-to-byte-array "dav"))
	  (:struct "host" ,(dbus-string-to-byte-array host))
	  (:struct "ssl" ,(dbus-string-to-byte-array ssl))))
       (t
	`((:struct "type" ,(dbus-string-to-byte-array method))
	  (:struct "host" ,(dbus-string-to-byte-array host)))))))

    (when user
      (add-to-list
       'mount-spec
       `(:struct "user" ,(dbus-string-to-byte-array user))
       'append))

    (when domain
      (add-to-list
       'mount-spec
       `(:struct "domain" ,(dbus-string-to-byte-array domain))
       'append))

    (when port
      (add-to-list
       'mount-spec
       `(:struct "port" ,(dbus-string-to-byte-array (number-to-string port)))
       'append))

    ;; Return.
    mount-spec))


;; Connection functions

(defun tramp-gvfs-maybe-open-connection (vec)
  "Maybe open a connection VEC.
Does not do anything if a connection is already open, but re-opens the
connection if a previous connection has died for some reason."

  ;; We set the file name, in case there are incoming D-Bus signals or
  ;; D-Bus errors.
  (setq tramp-gvfs-dbus-event-vector vec)

  ;; For password handling, we need a process bound to the connection
  ;; buffer.  Therefore, we create a dummy process.  Maybe there is a
  ;; better solution?
  (unless (get-buffer-process (tramp-get-buffer vec))
    (let ((p (make-network-process
	      :name (tramp-buffer-name vec)
	      :buffer (tramp-get-buffer vec)
	      :server t :host 'local :service t)))
      (tramp-set-process-query-on-exit-flag p nil)))

  (unless (tramp-gvfs-connection-mounted-p vec)
    (let* ((method (tramp-file-name-method vec))
	   (user (tramp-file-name-user vec))
	   (host (tramp-file-name-host vec))
	   (object-path
	    (tramp-gvfs-object-path
	     (tramp-make-tramp-file-name method user host ""))))

      (if (zerop (length (tramp-file-name-user vec)))
	  (tramp-message
	   vec 3 "Opening connection for %s using %s..." host method)
	(tramp-message
	 vec 3 "Opening connection for %s@%s using %s..." user host method))

      ;; Enable auth-sorce and password-cache.
      (tramp-set-connection-property
       (tramp-get-connection-process vec) "first-password-request" t)

      ;; There will be a callback of "askPassword", when a password is
      ;; needed.
      (dbus-register-method
       :session dbus-service-emacs object-path
       tramp-gvfs-interface-mountoperation "askPassword"
       'tramp-gvfs-handler-askpassword)

      ;; There could be a callback of "askQuestion", when adding fingerprint.
      (dbus-register-method
       :session dbus-service-emacs object-path
       tramp-gvfs-interface-mountoperation "askQuestion"
       'tramp-gvfs-handler-askquestion)

      ;; The call must be asynchronously, because of the "askPassword"
      ;; or "askQuestion"callbacks.
      (with-tramp-dbus-call-method vec nil
	:session tramp-gvfs-service-daemon tramp-gvfs-path-mounttracker
	tramp-gvfs-interface-mounttracker "mountLocation"
	`(:struct
	  ,(dbus-string-to-byte-array "/")
	  ,(tramp-gvfs-mount-spec vec))
	(dbus-get-unique-name :session)
	:object-path object-path)

      ;; We must wait, until the mount is applied.  This will be
      ;; indicated by the "mounted" signal, i.e. the "fuse-mountpoint"
      ;; file property.
      (with-timeout
	  (60
	   (if (zerop (length (tramp-file-name-user vec)))
	       (tramp-error
		vec 'file-error
		"Timeout reached mounting %s using %s" host method)
	     (tramp-error
	      vec 'file-error
	      "Timeout reached mounting %s@%s using %s" user host method)))
	(while (not (tramp-get-file-property vec "/" "fuse-mountpoint" nil))
	  (sit-for 0.1)))

      ;; We set the connection property "started" in order to put the
      ;; remote location into the cache, which is helpful for further
      ;; completion.
      (tramp-set-connection-property vec "started" t)

      (if (zerop (length (tramp-file-name-user vec)))
	  (tramp-message
	   vec 3 "Opening connection for %s using %s...done" host method)
	(tramp-message
	 vec 3
	 "Opening connection for %s@%s using %s...done" user host method)))))


;; D-Bus BLUEZ functions.

(defun tramp-bluez-list-devices ()
  "Returns all discovered bluetooth devices as list.
Every entry is a list (NAME ADDRESS).

If `tramp-bluez-discover-devices-timeout' is an integer, and the last
discovery happened more time before indicated there, a rescan will be
started, which lasts some ten seconds.  Otherwise, cached results will
be used."
  ;; Reset the scanned devices list if time has passed.
  (and (integerp tramp-bluez-discover-devices-timeout)
       (integerp tramp-bluez-discovery)
       (> (tramp-time-diff (current-time) tramp-bluez-discovery)
	  tramp-bluez-discover-devices-timeout)
       (setq tramp-bluez-devices nil))

  ;; Rescan if needed.
  (unless tramp-bluez-devices
    (let ((object-path
	   (with-tramp-dbus-call-method tramp-gvfs-dbus-event-vector t
	     :system tramp-bluez-service "/"
	     tramp-bluez-interface-manager "DefaultAdapter")))
      (setq tramp-bluez-devices nil
	    tramp-bluez-discovery t)
      (with-tramp-dbus-call-method tramp-gvfs-dbus-event-vector nil
	:system tramp-bluez-service object-path
	tramp-bluez-interface-adapter "StartDiscovery")
      (while tramp-bluez-discovery
	(read-event nil nil 0.1))))
  (setq tramp-bluez-discovery (current-time))
  (tramp-message tramp-gvfs-dbus-event-vector 10 "%s" tramp-bluez-devices)
  tramp-bluez-devices)

(defun tramp-bluez-property-changed (property value)
  "Signal handler for the \"org.bluez.Adapter.PropertyChanged\" signal."
  (tramp-message tramp-gvfs-dbus-event-vector 6 "%s %s" property value)
  (cond
   ((string-equal property "Discovering")
    (unless (car value)
      ;; "Discovering" FALSE means discovery run has been completed.
      ;; We stop it, because we don't need another run.
      (setq tramp-bluez-discovery nil)
      (with-tramp-dbus-call-method tramp-gvfs-dbus-event-vector t
	:system tramp-bluez-service (dbus-event-path-name last-input-event)
	tramp-bluez-interface-adapter "StopDiscovery")))))

(dbus-register-signal
 :system nil nil tramp-bluez-interface-adapter "PropertyChanged"
 'tramp-bluez-property-changed)

(defun tramp-bluez-device-found (device args)
  "Signal handler for the \"org.bluez.Adapter.DeviceFound\" signal."
  (tramp-message tramp-gvfs-dbus-event-vector 6 "%s %s" device args)
  (let ((alias (car (cadr (assoc "Alias" args))))
	(address (car (cadr (assoc "Address" args)))))
    ;; Maybe we shall check the device class for being a proper
    ;; device, and call also SDP in order to find the obex service.
    (add-to-list 'tramp-bluez-devices (list alias address))))

(dbus-register-signal
 :system nil nil tramp-bluez-interface-adapter "DeviceFound"
 'tramp-bluez-device-found)

(defun tramp-bluez-parse-device-names (ignore)
  "Return a list of (nil host) tuples allowed to access."
  (mapcar
   (lambda (x) (list nil (car x)))
   (tramp-bluez-list-devices)))

;; Add completion function for OBEX method.
(when (dbus-ping :system tramp-bluez-service)
  (tramp-set-completion-function
   "obex" '((tramp-bluez-parse-device-names ""))))


;; D-Bus zeroconf functions.

(defun tramp-zeroconf-parse-workstation-device-names (ignore)
  "Return a list of (user host) tuples allowed to access."
  (mapcar
   (lambda (x)
     (list nil (zeroconf-service-host x)))
   (zeroconf-list-services "_workstation._tcp")))

(defun tramp-zeroconf-parse-webdav-device-names (ignore)
  "Return a list of (user host) tuples allowed to access."
  (mapcar
   (lambda (x)
     (let ((host (zeroconf-service-host x))
	   (port (zeroconf-service-port x))
	   (text (zeroconf-service-txt x))
	   user)
       (when port
	 (setq host (format "%s%s%d" host tramp-prefix-port-regexp port)))
       ;; A user is marked in a TXT field like "u=guest".
       (while text
	 (when (string-match "u=\\(.+\\)$" (car text))
	   (setq user (match-string 1 (car text))))
	 (setq text (cdr text)))
       (list user host)))
   (zeroconf-list-services "_webdav._tcp")))

;; Add completion function for DAV and DAVS methods.
(when (dbus-ping :system zeroconf-service-avahi)
  (zeroconf-init tramp-gvfs-zeroconf-domain)
  (tramp-set-completion-function
   "sftp" '((tramp-zeroconf-parse-workstation-device-names "")))
  (tramp-set-completion-function
   "dav" '((tramp-zeroconf-parse-webdav-device-names "")))
  (tramp-set-completion-function
   "davs" '((tramp-zeroconf-parse-webdav-device-names ""))))

(provide 'tramp-gvfs)

;;; TODO:

;; * process-file and start-file-process on the local machine, but
;;   with remote files.
;; * Host name completion via smb-server or smb-network.
;; * Check, how two shares of the same SMB server can be mounted in
;;   parallel.
;; * Apply SDP on bluetooth devices, in order to filter out obex
;;   capability.
;; * Implement obex for other serial communication but bluetooth.

;;; tramp-gvfs.el ends here
