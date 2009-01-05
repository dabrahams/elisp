;;; Stolen directly from http://teichman.org/~peter/init.el.  Only a
;;; few small modifications

;;; Everybody needs things like ignore-errors and such.
(require 'cl)

;;; Here is my .emacs setup.  It has grown over a period of a few
;;; years.  It allows you to keep an elisp tree in version control,
;;; and makes it easy to try out new packages from time to time.
;;;
;;; There is one configurable variable, init-path.  I happen to put
;;; my elisp tree in ~/elisp.

(defvar init-path (expand-file-name "~/elisp"))

;;; This file, init.el, goes in ~/elisp.  That way, the entire
;;; contents of your .emacs file can be:
;;;
;;; (load-file "~/elisp/init.el")
;;;
;;; If you use xemacs, put that line in ~/.xemacs/init.el
;;; 
;;; If you want to use a different directory, you can do something
;;; along these lines:
;;;
;;; (setq init-path (expand-file-name "~/emacs"))
;;; (load-file (expand-file-name "init.el" init-path))
;;;
;;; Since the definition of init-path above is with a defvar, this
;;; file doesn't need to change, even if you want it in a different
;;; path.  Setting init-path in your .emacs file will override the
;;; value above.


;;; Now, on to the features of this setup.
;;; 
;;; 1) Any directory with an .el file below ~/elisp will be added to
;;; your load-path at start, or any time you run
;;; add-init-path-to-load-path.
;;;
;;; 2) Any *-settings.el files under ~/elisp/settings will be loaded
;;; automatically on start.
;;;
;;; 3) All .el files under ~/elisp/packages will be byte-compiled if
;;; you run byte-recompile-init-path.


;;; This leads to an easy usage pattern.  Any time you get some elisp
;;; from someone else, drop it into the ~/elisp/packages tree.  I tend
;;; to put single files directly in ~/elisp/packages and multi-file
;;; packages in their own subdirectories.

;;; Any time you want to configure a package, either use M-x configure
;;; or create a small settings file for that package in
;;; ~/elisp/settings.

;;; For optimal results, keep the whole tree in a version control
;;; system.  That also makes it easy to use it from several different
;;; computers.

;;; Hopefully you'll never have to look at this file again!

(setq custom-file (expand-file-name "custom.el" init-path))
(load-file custom-file)

(setq init-packages-path (expand-file-name "package.d" init-path)
      init-config-path (expand-file-name "config.d" init-path)
      init-autoload-path (expand-file-name "autoload.d" init-path)
)

(defun find-subdirs-containing (dir pattern)
  "Return a list of all deep subdirectories of DIR that contain files
that match PATTERN."
  (let* ((ret nil)
	 (files (directory-files dir))
	 (max-lisp-eval-depth 3000))
    (while files
      (let* ((file (car files))
	     (path (expand-file-name file dir)))
	(if (and (file-directory-p path)
		 (not (string-match "^\\.+" file)))
	    (setq ret (append ret (find-subdirs-containing path pattern)))
	  (if (string-match pattern file)
	      (add-to-list 'ret dir))))
      (setq files (cdr files)))
    ret))

(defun byte-recompile-init-path ()
  "Recompile all the .el files under init-packages-path, if they're
not up to date.  This can be run from the command line with:
$ emacs -l ~/.emacs -batch -f byte-recompile-init-path"
  (interactive)
  (let ((generated-autoload-file (expand-file-name "my-loaddefs.el" init-config-path)))
    (dolist (dir (find-subdirs-containing init-packages-path "\\.el$"))
      (byte-recompile-directory dir 0)
      (update-directory-autoloads dir))
    (byte-recompile-file loaddefs))
  )

(defun add-init-path-to-load-path ()
  "Add the subdirectories of init-path that contain elisp files to the
load-path.  This can safely be run many times in a session, without
adding multiple copies of the directories.  The new directories are
prepended to emacs's initial load-path."
  (interactive)
  (setq load-path (append (find-subdirs-containing init-path "\\.el$") initial-load-path)))

;;; Add the init-path tree to the load-path
(setq initial-load-path load-path)
(add-init-path-to-load-path)

(defun add-init-path-to-info-path ()
  "Add the subdirectories of init-path that contain info directory
files to the Info-directory-list.  This can safely be run many times
in a session, without adding multiple copies of the directories.  The
new directories are prepended to emacs's initial Info path."
  (interactive)
  (setq Info-directory-list (append (find-subdirs-containing init-path "\\.info$") initial-info-path)))

;;; Make sure we have /sbin in the path - SUSE puts install-info there
(add-to-list 'exec-path "/sbin")

(defun add-info-dir-files-to-path (tree)
  "Add all the info files under TREE to info \"dir\" files"
  (let* ((info-regex "\\.info$")
	 (info-dirs (find-subdirs-containing tree info-regex)))
    (mapcar (lambda (dir)
	      (dolist (file (directory-files dir t info-regex))
		(call-process "install-info" nil nil nil
			      (format "--dir-file=%s/dir" dir)
			      (format "--info-file=%s" file))))
	    info-dirs)))

;;; Create dir files for any info files in the init-path
(add-info-dir-files-to-path init-path)

;;; Add the init-path tree to the Info path
(require 'info)
(info-initialize)
(setq initial-info-path Info-directory-list)
(add-init-path-to-info-path)

; So you can tell the difference between GNU Emacs and XEmacs in your
; settings files
(setq running-xemacs (string-match "XEmacs" (emacs-version)))

; Load ~/elisp/config.d/*.el (in sorted order).
(dolist (file (directory-files init-config-path t "^\\([^.]\\|\\.[^#]\\).*\\.el$"))
  (load-file file))

; Prepare all autoloads.d/xxx-setup.el files to load automatically
; after the xxx library.  See
; http://www.emacsblog.org/2007/10/07/declaring-emacs-bankruptcy/#comment-5937
(dolist 
    ;; For file in (*-setup.el files in init-autoload-path)
    (file 
     (let ((default-directory init-autoload-path))
       (mapcar 'file-name-sans-extension
               (file-expand-wildcards "*-setup.el")))
     )

  (eval-after-load
      ;; convert the first part of the filename to a symbol
      (intern 
       (and (string-match "^\\(.*\\)-setup" file) (match-string 1 file)))
    `(load ,(expand-file-name file init-autoload-path))))

(provide 'init)
