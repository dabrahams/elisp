;;; Stolen directly from http://teichman.org/~peter/init.el.  Only a
;;; few small modifications

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
;;; (load "~/elisp/init")
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

(defun strip-lisp-suffix (filename)
"Strip off any lisp suffix such as \".el\" to retrieve a library
name that can be loaded with emacs finding the most-optimized
representation."
  (catch 'stripped
   (dolist (suf (get-load-suffixes))
     (let ((stripped 
            (replace-regexp-in-string (concat ".\\(" (regexp-quote suf) "\\)\\'")
                                      "" filename nil nil 1)))
       (if (not (equal stripped filename))
         (throw 'stripped stripped))))
   filename))

(defun load-optimized (file-or-library-name)
  "Load a compiled version of the file or library if possible; else load a source version"
  (load (strip-lisp-suffix file-or-library-name)))

(setq custom-file (expand-file-name "custom.el" init-path))
(load-optimized custom-file)

(setq init-package-path (expand-file-name "package.d" init-path)
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

(defun find-subdirs-containing-elisp (dir)
  (find-subdirs-containing dir "\\.el\\(\\.gz\\)?\\'"))

(defun ensure-byte-compilable-autoload-file (file)
  "If FILE doesn't already exist, create it as a byte-compilable
  autoload file (the default created by autoload.el has a local
  no-byte-compile variable that suppresses byte compilation)."
  ;; Make sure my own autoload-file is byte-compilable.  If we don't
  ;; explicitly strip out the no-byte-compile variable, autoload.el
  ;; will create it on demand
  (unless (file-exists-p file)
    (write-region 
     (replace-regexp-in-string ";; no-byte-compile: t\n" "" (autoload-rubric file)) nil file)
    (with-current-buffer (find-file-noselect file)
      (save-buffer))
    ))

(require 'autoload)
(defun byte-recompile-init-path ()
  "Recompile all the .el files under init-package-path, if they're
not up to date.  This can be run from the command line with:
$ emacs -l ~/.emacs -batch -f byte-recompile-init-path"
  (interactive)
  (require 'bytecomp)

  (let ((generated-autoload-file ; tells update-directory-autoloads where to stick it
         (expand-file-name "my-loaddefs.el" init-config-path))
        (package-dirs
         (find-subdirs-containing-elisp init-package-path))
        (non-package-dirs
         (append (find-subdirs-containing-elisp init-config-path)
                 (find-subdirs-containing-elisp init-autoload-path)))
        )
    
    (letf ((byte-compile-verbose nil) (font-lock-verbose nil) (noninteractive t))

      ;; Make sure my own autoload-file is byte-compilable.  
      (ensure-byte-compilable-autoload-file generated-autoload-file)

      ;; byte compile all my packages and grab their autoloads
      (dolist (d package-dirs)
        (byte-recompile-directory d 0)
        (update-directory-autoloads d)
        )

      ;; my autoload-file lives in config.d/ so we can compile that now.
      (dolist (d non-package-dirs)
        (byte-recompile-directory d 0))
      )
    )
  )

(defun add-init-path-to-load-path ()
  "Add the subdirectories of init-path that contain elisp files to the
load-path.  This can safely be run many times in a session, without
adding multiple copies of the directories.  The new directories are
prepended to emacs's initial load-path."
  (interactive)
  (setq load-path (append (find-subdirs-containing-elisp init-path) initial-load-path)))

;;; Add the init-path tree to the load-path
(setq initial-load-path load-path)
(add-init-path-to-load-path)

; So you can tell the difference between GNU Emacs and XEmacs in your
; settings files
(setq running-xemacs (string-match "XEmacs" (emacs-version)))

; Load ~/elisp/config.d/*.el (in sorted order).
(dolist (file (directory-files init-config-path t "^\\([^.]\\|\\.[^#]\\).*\\.el$"))
  (load-optimized file))

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
      ;; identifying the package on which we want to piggyback this
      ;; setup file
      (intern 
       (and (string-match "^\\(.*\\)-setup" file) (match-string 1 file)))
    `(load-optimized ,(expand-file-name file init-autoload-path))))

(provide 'init)
