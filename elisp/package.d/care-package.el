;;; care-package --- Loads Emacs code and optional packages from BoostPro Training

;; Copyright (C) 2010 BoostPro Computing

;; Author: John Wiegley <johnw@boostpro.com>
;; Created: 29 Nov 2010
;; Version: 1.0
;; Keywords: demo sample
;; X-URL: http://bbn-emacs.boostpro.com

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

(add-to-list 'load-path (file-name-directory load-file-name))
(message "Added %s to your load-path" (file-name-directory load-file-name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'browse-kill-ring)
(require 'column-marker)
(require 'hide-search)
(require 'linum)
(require 'regex-tool)
(require 'repeat-insert)
(require 'session)
(require 'zencoding-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Package initializations
(browse-kill-ring-default-keybindings)

(add-hook 'after-init-hook 'session-initialize)
(run-with-idle-timer 900 t 'session-save-session)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key global-map [(meta ?T)] 'tags-search)

(define-key global-map [(meta ?\')] 'insert-pair)
(define-key global-map [(meta ?\")] 'insert-pair)

(define-key global-map [(meta ?`)]  'other-frame)

(define-key global-map [(control return)] 'other-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key ctl-x-map [?d] 'delete-whitespace-rectangle)
(define-key ctl-x-map [?t] 'toggle-truncate-lines)

(define-key ctl-x-map [(control shift ?b)] 'ibuffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key mode-specific-map [?c] 'compile)
(define-key mode-specific-map [?f] 'flush-lines)
(define-key mode-specific-map [?k] 'keep-lines)
(define-key mode-specific-map [?o] 'customize-option)
(define-key mode-specific-map [?O] 'customize-group)
(define-key mode-specific-map [?r] 'replace-regexp)
(define-key mode-specific-map [?s] 'replace-string)
(define-key mode-specific-map [?z] 'clean-buffer-list)
(define-key mode-specific-map [?\[] 'align-regexp)
(define-key mode-specific-map [?=] 'count-matches)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-after-load "dired"
  '(progn
     (require 'wdired)
     (define-key dired-mode-map [?r] 'wdired-change-to-wdired-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun delete-indentation-forward ()
  (interactive)
  (delete-indentation t))

(define-key global-map [(meta ?j)] 'delete-indentation-forward)
(define-key global-map [(meta ?J)] 'delete-indentation)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun collapse-or-expand ()
  (interactive)
  (if (> (length (window-list)) 1)
      (delete-other-windows)
    (bury-buffer)))

(define-key global-map [(control ?z)] 'collapse-or-expand)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun isearch-forward-other-window ()
  (interactive)
  (split-window-vertically)
  (call-interactively 'isearch-forward))

(define-key global-map [(control meta ?s)] 'isearch-forward-other-window)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun duplicate-line ()
  "Duplicate the line containing point."
  (interactive)
  (save-excursion
    (let (line-text)
      (goto-char (line-beginning-position))
      (let ((beg (point)))
        (goto-char (line-end-position))
        (setq line-text (buffer-substring beg (point))))
      (if (eobp)
          (insert ?\n)
        (forward-line))
      (open-line 1)
      (insert line-text))))

(define-key ctl-x-map [(control ?d)] 'duplicate-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun toggle-code-file ()
  (interactive)
  (let* ((path (buffer-file-name))
         (base (file-name-sans-extension path)))
    (cond ((string-match "\\.\\(c\\(c\\|pp\\)?\\|mm?\\)\\'"
                         path)
           (find-file (concat base ".h")))
          ((string-match "\\.h\\'" path)
           (dolist (ext '(".cc" ".cpp" ".c" ".mm" ".m"))
             (if (file-readable-p (concat base ext))
                 (find-file (concat base ext))))))))

(define-key mode-specific-map [tab] 'toggle-code-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun keep-mine ()
  (interactive)
  (beginning-of-line)
  (assert (or (looking-at "<<<<<<")
              (re-search-backward "^<<<<<<" nil t)
              (re-search-forward "^<<<<<<" nil t)))
  (goto-char (match-beginning 0))
  (let ((beg (point)))
    (forward-line)
    (delete-region beg (point))
    (re-search-forward "^=======")
    (setq beg (match-beginning 0))
    (re-search-forward "^>>>>>>>")
    (forward-line)
    (delete-region beg (point))))

(defun keep-theirs ()
  (interactive)
  (beginning-of-line)
  (assert (or (looking-at "<<<<<<")
              (re-search-backward "^<<<<<<" nil t)
              (re-search-forward "^<<<<<<" nil t)))
  (goto-char (match-beginning 0))
  (let ((beg (point)))
    (re-search-forward "^=======")
    (forward-line)
    (delete-region beg (point))
    (re-search-forward "^>>>>>>>")
    (beginning-of-line)
    (setq beg (point))
    (forward-line)
    (delete-region beg (point))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun align-code (beg end &optional arg)
  (interactive "rP")
  (if (null arg)
      (align beg end)
    (let ((end-mark (copy-marker end)))
      (indent-region beg end-mark nil)
      (align beg end-mark))))

(define-key global-map [(meta ?\[)] 'align-code)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun unfill-paragraph (arg)
  (interactive "*p")
  (let (beg end)
    (forward-paragraph arg)
    (setq end (copy-marker (- (point) 2)))
    (backward-paragraph arg)
    (if (eolp)
	(forward-char))
    (setq beg (point-marker))
    (when (> (count-lines beg end) 1)
      (while (< (point) end)
	(goto-char (line-end-position))
	(let ((sent-end (memq (char-before) '(?. ?\; ?! ??))))
	  (delete-indentation 1)
	  (if sent-end
	      (insert ? )))
	(end-of-line))
      (save-excursion
	(goto-char beg)
	(while (re-search-forward "[^.;!?:]\\([ \t][ \t]+\\)" end t)
	  (replace-match " " nil nil nil 1))))))

(define-key ctl-x-map [(meta ?q)] 'unfill-paragraph)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun delete-current-line (&optional arg)
  (interactive "p")
  (let ((here (point)))
    (beginning-of-line)
    (kill-line arg)
    (goto-char here)))

(define-key mode-specific-map [?d] 'delete-current-line)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'care-package)

;;; care-package.el ends here
