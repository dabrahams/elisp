;;; gravatar.el --- gravatar fetch/store functions

;; Copyright (C) 2008  Iwata

;; Author: Iwata <iratqq@gmail.com>
;; Keywords: faces, tools, extensions, mail

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;
;; Usage:
;; (require 'gravatar)
;; (setq gnus-gravatar-directory "~/.emacs-gravatar/")
;;

;;
;; detail of gravatar API is following,
;;  http://en.gravatar.com/site/implement/url
;;

(require 'md5)
(require 'image)
(require 'gnus-art)
(require 'gnus-picon)
(require 'mail-parse)

(defalias 'gnus-gravatar-insert-glyph 'gnus-picon-insert-glyph)
(defalias 'gnus-gravatar-create-glyph 'gnus-picon-create-glyph)

(defvar gravatar-active-p t
  "Fetch gravatar icon from network")

(defvar gnus-treat-gravatar-icon
  (if (and (gnus-image-type-available-p 'png)
	   (gnus-image-type-available-p 'jpeg)
	   (gnus-image-type-available-p 'gif))
      'head nil))

(add-to-list 'gnus-treatment-function-alist
              '(gnus-treat-gravatar-icon gnus-treat-gravatar-icon))

(defvar gravatar-unregistered-icon-query-alist
  '((none      . "")
    (identicon . "&d=identicon")
    (monsterid . "&d=monsterid")
    (wavatar   . "&d=wavatar")))

(defcustom gnus-gravatar-unregistered-icon 'none
  "Icon type of unregistered user."
  :group 'gravatar)

(defcustom gnus-gravatar-style
  (if (boundp 'gnus-picon-style) gnus-picon-style 'inline)
  "*How should gravatar icons be displayed.
If `inline', the textual representation is replaced.  If `right', picons are
added right to the textual representation."
  :type '(choice (const inline)
                 (const right))
  :group 'gnus-gravatar)

(defcustom gravatar-base-url "http://www.gravatar.com/avatar/"
  "URL of gravatar's www site."
  :group 'gravatar)

(defcustom gnus-gravatar-directory "~/.emacs-gravatar/"
  "Placement of picture files."
  :group 'gravatar)

(defcustom gravatar-retrieval-program "wget -q -O '%s' '%s'"
  "URL retrieving program."
  :group 'gravatar)

(defcustom gravatar-icon-size 45
  "Display icon size"
  :group 'gravatar)

(defcustom gravatar-unknown-icon "unknown-45x45.jpg"
  "Display icon when pixmap is unrecognized"
  :group 'gravatar)

(defun gnus-gravatar-split-address (address)
  (car (mail-header-parse-address address)))

(defun gravatar-retrieve (path url)
  (if gravatar-active-p
      (let ((spath (expand-file-name gnus-gravatar-directory)))
	(if (not (file-exists-p spath))
	    (make-directory spath t))
	(shell-command-to-string
	 (format gravatar-retrieval-program
		 (expand-file-name path)
		 url)))))

(defun gravatar-make-query-size (size)
  (format "s=%s" (int-to-string size)))

(defun gravatar-make-query-rate (rate)
  ;; g, pg, r or x
  (format "r=%s" rate))

(defun gravatar-make-query (opts)
  (if (eq opts nil)
      ""
    (concat "?" (mapconcat (lambda (x) x) opts "&")
	    ;; unknown user
	    (cdr (assq gnus-gravatar-unregistered-icon
		       gravatar-unregistered-icon-query-alist)))))

(defun gravatar-make-store-filename-from-user (user)
  (let ((string user))
    (while (string-match "[\\. ]" string)
      (setq string (replace-match "_" nil nil string)))
    string))

(defun gravatar-make-store-filename (user &rest opts)
  (concat
   gnus-gravatar-directory
   ;;(gravatar-make-id-from-name user)
   (gravatar-make-store-filename-from-user
    (gnus-gravatar-split-address user))
   (if (eq opts nil)
       ""
     (concat "_" (mapconcat (lambda (x) x) opts "_")))))

(defun gravatar-make-id-from-name (user)
  (md5
   (apply 'concat (split-string (downcase user) " "))))

(defun gravatar-make-url (user &rest opts)
  (concat
   gravatar-base-url
   (gravatar-make-id-from-name user)
   (gravatar-make-query opts)))

(defun gnus-gravatar-transform-field (header category)
  (gnus-with-article-headers
    (let ((field (mail-fetch-field header))
          file image len)
      (when (and field
		 (setq field (gnus-gravatar-split-address (downcase field)))
		 (setq file
		       (let* ((size (gravatar-make-query-size gravatar-icon-size))
			      (fn (gravatar-make-store-filename field size)))
			 (if (file-exists-p fn)
			     ;; use cache
			     fn
			   (progn
			     (gravatar-retrieve
			      fn
			      (gravatar-make-url field size))
			     (if (file-exists-p fn)
				 fn
			       (format "%s/%s"
				       gnus-gravatar-directory
				       gravatar-unknown-icon))))))
		 (setq image (cons (gnus-gravatar-create-glyph file) header))
		 (gnus-article-goto-header header))
	(case gnus-gravatar-style
          (right
           (setq len (car (image-size (car image))))
           (when (and len (> len 0))
             (goto-char (point-at-eol))
             (insert (propertize
                      " " 'display
                      (cons 'space
                            (list :align-to (- (window-width) 1 len))))))
           (goto-char (point-at-eol)))
          (inline nil))
	(gnus-gravatar-insert-glyph image category)))))

(defun gnus-treat-gravatar-icon ()
  "Display gravatar icons in the from header.
If icons are already displayed, remove them."
  (interactive)
  (let ((wash-gravatar-p buffer-read-only))
    (gnus-with-article-headers
      (if (and wash-gravatar-p (memq 'gravatar-icon gnus-article-wash-types))
          (gnus-delete-images 'gravatar-icon)
        (gnus-gravatar-transform-field "from" 'gravatar-icon)))))

(defun gravator-toggle ()
  "Toggle `gravatar-retrieve'"
  (interactive)
  (setq gravatar-active-p (not gravatar-active-p))
  (if gravatar-active-p
      (message "gravatar-active-p on")
    (message "gravatar-active-p off")))


;; test
(defun gravatar-insert-image (user &rest opts)
  (let ((args (append (list user) opts)))
    (insert-image
     (create-image
      (apply
       'gravatar-make-store-filename args)))))

(if nil
    (let ((user "test@example.com")
	  (size (gravatar-make-query-size gravatar-icon-size)))
      (message
       (gravatar-retrieve
	(gravatar-make-store-filename user size)
	(gravatar-make-url user size)))
      (gravatar-insert-image user size)))

(provide 'gravatar)

;;; gravatar.el ends here
