;;; initsplit --- code to split customizations into different files

;; Copyright (C) 2000, 2001 John Wiegley

;; Author: John Wiegley <johnw@gnu.org>
;; Created:  8 Feb 2000
;; Version: 1.6
;; Keywords: lisp
;; X-URL: http://www.gci-net.com/users/j/johnw/emacs.html

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This file allows you to split Emacs customizations (set via M-x
;; customize) into different files, based on the names of the
;; variables.  It uses a regexp to match against each face and
;; variable name, and associates with a file that the variable should
;; be stored in.

;; To use it, just load the file in your .emacs:
;;
;;   (load "initsplit")
;;
;; If you want configuration files byte-compiled, add this after it:
;;
;;   (add-hook 'after-save-hook 'initsplit-byte-compile-files t)

;; Note that that you *must* load each file that contains your various
;; customizations from your .emacs.  Otherwise, the variables won't
;; all be set, and the next time you use the customize interface, it
;; will delete the settings in those other files.

;; Then, customize the variable `initsplit-customizations-alist', to
;; associate various configuration names with their respective
;; initialization files.

;; I find this module most useful for splitting up Gnus and Viper
;; customizations.

;;; History:

;;; Code:

(require 'cl)

(defconst initsplit-version "1.7"
  "This version of initsplit.")

(defgroup initsplit nil
  "Code to split customizations into different files."
  :group 'initialization)

;;; User Variables:

(defcustom initsplit-load-hook nil
  "*A hook that gets run after \"initsplit.el\" has been loaded."
  :type 'hook
  :group 'initsplit)

(defcustom initsplit-customizations-alist nil
  "*An alist that describes how to split up init file customizations.

The \"Load\" selection determines when the file will be loaded.

* `'eagerly': loaded by initsplit when it is loaded

* `'lazily': loaded by some other means (e.g. eval-after-load),
  but before any customizations are written out to disk,
  initsplit will load it automatically if it hasn't already been
  loaded, to avoid losing settings.

* `'manually': loaded by other means.  If it isn't /known/ to
  have been loaded by the time customizations are written to
  disk, its customizations will be backed up, and then *erased*.
  Legacy customization files should be transitioned to eager or
  lazy loading ASAP to avoid losing settings.
"
  :type '(repeat
	  (list (regexp  :tag "Var regexp")
		(file    :tag "Custom file")
		(boolean :tag "Byte-compile")
                (menu-choice :tag "Load this file:" 
                             :value 'eager
                             :notify (lambda (widget &rest ignore)
                                       (message "%S" (widget-value widget))
                                       (unless (widget-value widget)
                                         (warn "Manual loading is only here to support legacy configurations and not recommended; please choose one of the other settings.
`C-h v initsplit-customizations-alist RET' for more details
")))
                             (item :tag "eagerly" :value 'eager)
                             (item :tag "lazily" :value 'lazy)
                             (item :tag "manually (change me)" :value nil)
                             )))
  :group 'initsplit)

;;; User Functions:

(defun initsplit-load-behavior (filespec)
  "Return a list containing the load-behavior element of
customization tuple FILESPEC, or nil if FILESPEC has no
load-behavior set."
  (cadddr filespec))

(defconst declare-initsplit-loaded-files
  '(defvar initsplit-loaded-files nil
     "A list of known loaded customization files

If a legacy customization file is loaded before initsplit, it won't
t appear in this list until it is loaded again.")

  "A sexp that defines the initsplit-loaded-files variable."
  )
(eval declare-initsplit-loaded-files)

(defun initsplit-loaded (file)
  "if FILE appears in initsplit-customizations-alist, add its
true name to `initsplit-loaded-files'"
  (let ((f (file-truename file))
        (cust-files (mapcar (lambda (s) (file-truename (cadr s))) 
                            initsplit-customizations-alist)))
    (when (member f cust-files)
      (add-to-list 'initsplit-loaded-files f))))

;; Make sure to note any loaded initsplit customization files
(add-hook 'after-load-functions 'initsplit-loaded)


;;
;; initsplit-written-by-version
;;
(defun initsplit-written-by-version ()
  "Returns the version of initsplit that wrote customizations
into the current buffer, or `\"1.6\"' for versions predating 1.7"
  (or (bound-and-true-p initsplit-written-by-version) "1.6"))

(put 'initsplit-written-by-version 'safe-local-variable 'stringp)

;;
;;
;;
(defun initsplit-save-prepare ()
  "For all customization files that haven't already been loaded,
back up files written prior to version 1.7 and load the others.
Return a list of buffers that can be killed after customizations
are saved."
  (let (buffers-to-kill)

    (dolist (s initsplit-customizations-alist)
      (let* ((f (file-truename (cadr s)))
             (buffer-existed (get-file-buffer f)))

        (condition-case err

            (with-current-buffer (find-file-noselect f)

              (unless buffer-existed
                (setq buffers-to-kill (cons (current-buffer) buffers-to-kill)))

              (unless (or (member f initsplit-loaded-files) (not (file-exists-p f)))
                (if ;(version<= "1.7" (initsplit-written-by-version))
                    (initsplit-load-behavior s)
                    (load f)

                  (let* ((backup-directory-alist nil)
                         (version-control t)
                         (backup (car (find-backup-file-name f))))

                    (warn (concat "Initsplit: Legacy customization file %s "
                                  "may not have been loaded already. "  
                                  "If not, its customizations will be overwritten, "
                                  "but I've saved a backup for you in %s. "
                                  "Please choose a non-`Legacy' load behavior appropriate " 
                                  "to your setup in the from interface for " 
                                  "`initsplit-customizations-alist'."
                                  )
                          (shell-quote-argument f) (shell-quote-argument backup))
                         (rename-file f backup))))
              )

          (error (mapc 'kill-buffer buffers-to-kill)
                 (signal (car err) (cdr err))))))
    buffers-to-kill))

(defadvice custom-save-faces (after initsplit-write-version
                                    activate compile preactivate)

  ;; Record the initsplit version in the file
  (add-file-local-variable-prop-line
   'initsplit-written-by-version initsplit-version)

  ;; Also add the code to put self in initsplit-loaded-files
  (save-excursion 
    (end-of-buffer)
    (let ((standard-output (current-buffer)))
      (print declare-initsplit-loaded-files)
      (print '(add-to-list 'inisplit-loaded-files (file-truename load-file-name)))))
  
(defadvice custom-save-all (around initsplit-custom-save-all 
                                   activate compile preactivate)
  "Wrapper over custom-save-all that saves customizations into
multiple files per initsplit-customizations-alist"

  ;; Store up the saved-value properties of all symbols
  ;; and remember that we haven't saved them yet
  (mapatoms 
   (lambda (symbol) 
     (if (put symbol 'initsplit-saved-value (get symbol 'saved-value))
         (put symbol 'initsplit-unsaved-p t))))

  (let ((buffers-to-kill (initsplit-save-prepare)))
    (unwind-protect

        ;; For each customization file, save appropriate symbols
        (dolist (s (append initsplit-customizations-alist 
                           `(("" ,(initsplit-custom-file)))))
          (let ((custom-file (cadr s)))

            ;; As-yet-unsaved symbols that match the regexp
            ;; get a saved-value property.  Others get nil.
            (mapatoms 
             (lambda (symbol)
               (put symbol 'saved-value 
                    (and (get symbol 'initsplit-unsaved-p)
                         (string-match (car s) (symbol-name symbol))
                         (progn (put symbol 'initsplit-unsaved-p nil)
                                (get symbol 'initsplit-saved-value))))))

            ad-do-it))

      ;; Cleanup: restore the saved-value properties
      (mapatoms 
       (lambda (symbol) 
         (put symbol 'saved-value (get symbol 'initsplit-saved-value))
         (put symbol 'initsplit-saved-value nil)))

      ;; Cleanup: kill extra buffers
      (mapc 'kill-buffer buffers-to-kill))))

(defun initsplit-current-file-truename ()
  (file-truename (buffer-file-name (current-buffer))))

(defun initsplit-custom-file ()
  (or custom-file user-init-file))

(defun initsplit-in-file-p (file)
  (string= (file-truename file) (initsplit-current-file-truename)))

(defun initsplit-in-custom-file-p ()
  (initsplit-in-file-p (initsplit-custom-file)))

(defun initsplit-byte-compile-current ()
  (byte-compile-file (initsplit-current-file-truename)))

(defun initsplit-byte-compile-files ()
  (if (initsplit-in-custom-file-p)
      (initsplit-byte-compile-current)
    (let ((cal initsplit-customizations-alist))
      (while cal
	(if (and (nth 2 (car cal))
		 (initsplit-in-file-p (nth 1 (car cal))))
	    (initsplit-byte-compile-current))
	(setq cal (cdr cal))))))

;;(add-hook 'after-save-hook 'initsplit-byte-compile-files t)

;;; Internal Functions:

(defconst initsplit-load-suffix-regexp
  (concat (mapconcat 'regexp-quote (get-load-suffixes) "\\|") "\\'"))

(defun initsplit-strip-lisp-suffix (path)
  (replace-regexp-in-string elhome-load-suffix-regexp "" path))

(provide 'initsplit)

;; Load eagerly-loaded customization files that haven't been loaded
;; already.
(dolist (s initsplit-customizations-alist)
  (when (and (eq (initsplit-load-behavior s) 'eager)
             (not (member (file-truename (cadr s)) initsplit-loaded-files)))
      (load (initsplit-strip-lisp-suffix (cadr s)))))
  
(run-hooks 'initsplit-load-hook)

;;; initsplit.el ends here
