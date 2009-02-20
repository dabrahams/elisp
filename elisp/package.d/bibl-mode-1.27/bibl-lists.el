;; bibl-lists -- part of bibl-mode
;; Copyright (C) 1994, 1995 Bryan O'Sullivan

;; Author: Bryan O'Sullivan <bos@serpentine.com>
;; Keywords: bibliographies, databases, Internet
;; $Revision: 1.20 $
;; $Date: 1995/06/06 17:26:50 $
;; $Source: /archive/pub/bosullvn/elisp/bibl-mode/RCS/bibl-lists.el,v $

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

(require 'bibl-mode)

(defconst bibl-names-menu
  '("Lists"
    ["Find record" bibl-names-find-record t]
    ["Find from top" bibl-names-search-from-top t])
  "Menu for bibliography names mode.")


;;;###autoload
(defun bibl-sort-buffer (type)
  "Sort the contents of a bibliography mode buffer.

If called with a prefix arg, sorts by keyword, otherwise by record
name.

Uses the value of case-fold-search to determine whether or not to
ignore case while sorting."
  (interactive "*P")

  (undo-boundary)
  (save-excursion
    (let ((contents (buffer-substring (bibl-buffer-min) (point-max)))
	  (old-buffer (current-buffer)))
      (set-buffer (get-buffer-create "*sort buffer*"))
      (make-local-variable 'page-delimiter)
      (setq page-delimiter "^[ \t\f\n]*$")
      (erase-buffer)
      (insert contents)

      (let ((top (point-min))
	    (records (list "dummy delimiter"))
	    (cnt 0))
	(goto-char top)
	(message "")
	(princ "Sorting ...")
	(while (< (point) (point-max))
	  (let ((opoint (point)))
	    (bibl-goto-record-end)

	    (let* ((curr records)
		   (txt (buffer-substring opoint (point))))
	      (forward-line 1)

	      (while (and (cdr curr)
			  (let* ((ccc (car (cdr curr)))
				 (header (if type "Keywords" "Name"))
				 (lelt (if (string-match
					    (concat header ": \\([^\n]+\\)\n")
					    ccc)
					   (substring ccc
						      (match-beginning 1)
						      (match-end 1))
					 ""))
				 (nelt (if (string-match
					    (concat header ": \\([^\n]+\\)\n")
					    txt)
					   (substring txt
						      (match-beginning 1)
						      (match-end 1))
					 "")))
			    (if case-fold-search
				(string-lessp (downcase lelt) (downcase nelt))
			      (string-lessp lelt nelt))))
		(setq curr (cdr curr)))

	      (setq cnt (1+ cnt))
	  
	      (if (= 0 (mod cnt 5))
		  (progn
		    (princ ".")
		    (sit-for 0)))
	      (let ((new (cons txt (cdr curr))))
		(setcdr curr new)))))
	(message "Inserting ...")
	(set-buffer old-buffer)
	(let ((min (bibl-buffer-min)))
	  (delete-region min (point-max))
	  (goto-char min))
	(setq records (cdr records))
	(while records
	  (insert (car records) "\n")
	  (setq records (cdr records))))))
  (message "Done"))
      

;;;###autoload
(defun bibl-list-keywords (&optional no-pop)
  "Make a list of the keywords found in a bibliography buffer.
Call with NO-POP set to something non-nil, or call interactively with
a prefix argument, to work with less window shuffling."
  (interactive "P")

  (let (old-buffer)
    (if bibl-use-any-buffer
	(if (eq major-mode 'bibl-mode)
	    (setq old-buffer (current-buffer))
	  (error "Current buffer not in bibliography mode!"))
      (setq old-buffer (find-file-noselect bibl-file-name)))
    
    (save-excursion
      (set-buffer (get-buffer-create "*Keywords*"))
      ;; Make sure the current buffer really is a name or keyword
      ;; buffer, and that it belongs to the current bibl-mode buffer,
      ;; and non-empty, and its owner has been saved (if we cache
      ;; keys).
      (if (and bibl-cache-keys
	       (boundp 'bibl-names-owner)
	       (eq bibl-names-owner old-buffer)
	       (not (eq (point-min) (point-max)))
	       (not (buffer-modified-p old-buffer)))
	  (if no-pop
	      (set-buffer old-buffer)
	    (pop-to-buffer (current-buffer))
	    (pop-to-buffer old-buffer))
  
	;; Accumulate an obarray of keywords by looking for the Keyword
	;; lines.  the symbol's names are all lower-case; their values
	;; are the keywords in their original case.
	(set-buffer old-buffer)
	(let ((keywords (make-vector 255 0)))
	  (save-excursion
	    (save-restriction
	      (widen)
	      (goto-char (bibl-buffer-min))
	      (while (re-search-forward "^Keywords:\\(.*\\)$" nil t)
		(let ((end (match-end 1)))
		  (goto-char (match-beginning 1))
		  (while (re-search-forward "[^, \t][^,]*" end t)
		    (let ((name (buffer-substring (match-beginning 0)
						  (match-end 0))))
		      (set (intern (downcase name) keywords) name)))))))

	  ;; Sort the keywords, ignoring case.
	  (setq keywords
		(mapcar 'symbol-value
			(sort (let (l)
				(mapatoms (function
					   (lambda (sym)
					     (setq l (cons sym l))))
					  keywords)
				l)
			      'string-lessp)))
	  
	  ;; List them in a new buffer.
	  (set-buffer "*Keywords*")
	  (bibl-names-mode "Keywords" old-buffer)

	  (toggle-read-only 1)
	  (toggle-read-only)
	  (erase-buffer)
	  (or no-pop
	      (pop-to-buffer (current-buffer)))
	  (let ((tail keywords))
	    (while tail
	      (insert (car tail) "\n")
	      (setq tail (cdr tail))))
	  (goto-char (point-min))
	  (toggle-read-only 1)
	  (if no-pop
	      (set-buffer old-buffer)
	    (pop-to-buffer old-buffer))
	  (and bibl-cache-keys
	       (save-buffer)))))))


;;;###autoload
(defun bibl-visit-list-keywords (&optional no-pop)
  "Visit a bibliography buffer and make a list of the keywords to be found.
See the documentation for `bibl-list-keywords' and `bibl-visit-bibliography'."
  (interactive "P")

  (call-interactively 'bibl-visit-bibliography)
  (bibl-list-keywords no-pop))


;;;###autoload
(defun bibl-list-names (&optional no-pop)
  "Make a list of the names found in a bibliography buffer.
Call with NO-POP set to something non-nil, or call interactively with
a prefix argument, to do this without any window shuffling."
  (interactive "P")

  (let (old-buffer)
    (if bibl-use-any-buffer
	(if (eq major-mode 'bibl-mode)
	    (setq old-buffer (current-buffer))
	  (error "Current buffer not in bibliography mode!"))
      (setq old-buffer (find-file-noselect bibl-file-name)))
    
    (save-excursion
      (set-buffer (get-buffer-create "*Names*"))
      ;; Make sure the current buffer really is a name or keyword
      ;; buffer, and that it belongs to the current bibl-mode buffer,
      ;; and non-empty, and its owner has been saved (if we cache
      ;; keys).
      (if (and bibl-cache-keys
	       (boundp 'bibl-names-owner)
	       (eq bibl-names-owner old-buffer)
	       (not (eq (point-min) (point-max)))
	       (not (buffer-modified-p old-buffer)))
	  (if no-pop
	      (set-buffer old-buffer)
	    (pop-to-buffer (current-buffer))
	    (pop-to-buffer old-buffer))
  
	;; Accumulate an obarray of names by looking for the Name
	;; lines.  The symbol's names are all lower-case; their values
	;; are the names in their original case.
	(set-buffer old-buffer)
	(let ((names (make-vector 255 0)))
	  (save-excursion
	    (save-restriction
	      (widen)
	      (goto-char (bibl-buffer-min))
	      (while (re-search-forward "^Name: \\(.*\\)$" nil t)
		(let ((name (buffer-substring (match-beginning 1)
					      (match-end 1))))
		  ;; We don't like names beginning with `the', `an' or `a'.
		  (let ((case-fold-search t))
		    (if (string-match "^\\(The\\|A\\|An\\) \\(.*\\)" name)
			(setq name (concat (substring name
						      (match-beginning 2)
						      (match-end 2))
					   ", "
					   (downcase
					    (substring name
						       (match-beginning 1)
						       (match-end 1))))))
		    (set (intern (downcase name) names) name))))))

	  ;; Sort the keywords, ignoring case.
	  (setq names
		(mapcar 'symbol-value
			(sort (let (l)
				(mapatoms (function
					   (lambda (sym)
					     (setq l (cons sym l))))
					  names)
				l)
			      'string-lessp)))

	  ;; List them in a new buffer.
	  (set-buffer "*Names*")
	  (bibl-names-mode "Name" old-buffer)
	  (toggle-read-only 1)
	  (toggle-read-only)
	  (erase-buffer)
	  (or no-pop
	      (pop-to-buffer (current-buffer)))
	  (let ((tail names))
	    (while tail
	      (insert (concat (car tail) "\n"))
	      (setq tail (cdr tail))))
	  (goto-char (point-min))
	  (toggle-read-only 1)
	  (if no-pop
	      (set-buffer old-buffer)
	    (pop-to-buffer old-buffer))
	  (and bibl-cache-keys
	       (save-buffer)))))))


;;;###autoload
(defun bibl-visit-list-names (&optional no-pop)
  "Visit a bibliography buffer and make a list of the names to be found.
See the documentation for `bibl-list-keywords' and `bibl-visit-bibliography'."
  (interactive "P")

  (call-interactively 'bibl-visit-bibliography)
  (bibl-list-names no-pop))


;;;###autoload
(defun bibl-names-find-record (&optional from-top)
  "Try to find a record in the bibliography file.
This operates on a name or keyword taken from a names buffer.  With a
prefix argument, the search goes from the top."
  (interactive "P")

  (or (eq major-mode 'bibl-names-mode)
      (error "You shouldn't be calling this function in this buffer!"))
  
  (save-excursion
    (beginning-of-line)
    (let ((beg (point)))
      (forward-line 1)
      (backward-char 1)
      (let ((topic (buffer-substring beg (point)))
	    (old-buffer (current-buffer))
	    (type bibl-names-type)
	    (ftop (or from-top bibl-from-top)))
	(set-buffer bibl-names-owner)
	(bibl-partial-expose)
	(pop-to-buffer (current-buffer))
	(if ftop
	    (progn
	      (setq ftop nil)
	      (goto-char (bibl-buffer-min))
	      (message "Wrapped search")))
	(if (re-search-forward (concat "^" type ":[^\n]*" topic "[^\n]*$")
			       nil t)
	    (if bibl-highlight-match
		(progn
		  (bibl-find-record-start)
		  (cond
		   ((eq bibl-emacs-flavour 'FSF)
		    (let ((ovly (make-overlay (match-beginning 0)
					      (match-end 0))))
		      (overlay-put ovly 'face bibl-highlight-match)
		      (sit-for bibl-highlight-sit)
		      (delete-overlay ovly)))
		   ((eq bibl-emacs-flavour 'Lucid)
		    (isearch-highlight (match-beginning 0) (match-end 0))
		    (sit-for bibl-highlight-sit)
		    (isearch-dehighlight t)))))
	  (setq ftop t)
	  (message "No further matches"))
	(pop-to-buffer old-buffer)
	(setq bibl-from-top ftop)))))


(defun bibl-names-mouse-select (e)
  "Select the record under the mouse in bibl-names-mode."
  (interactive "@e")
  
  (or (eq major-mode 'bibl-names-mode)
      (error "Mode bogons!  Ack!"))
  (mouse-set-point e)
  (bibl-names-find-record))


(defun bibl-names-search-from-top ()
  "Search on an entry from the top of the buffer."
  (interactive)
  (bibl-names-find-record 1))


(defun bibl-names-lucid-menu (e)
  (interactive "@e")
  (popup-menu bibl-names-menu))


;;;###autoload
(defun bibl-names-mode (&optional type owner)
  "Major mode for tracking keyword and record names for bibliography files.
Not all that major, but since it's illegal to do anything else while
in here, I might as well make it so.

Commands:
\\{bibl-names-mode-map}

Entry to this mode calls the value of `bibl-names-mode-hooks' if that
value is non-nil."
  (interactive)

  (kill-all-local-variables)

  (setq major-mode 'bibl-names-mode
	mode-name "Bibliography Names")

  (make-local-variable 'bibl-names-type)
  (make-local-variable 'bibl-names-owner)
  (make-local-variable 'bibl-from-top)

  (setq bibl-names-type type
	bibl-names-owner owner
	bibl-from-top nil)
  (use-local-map bibl-names-mode-map)
  (put 'bibl-names-mode 'mode-class 'special)
  
  (cond
   ;; ((eq bibl-emacs-flavour 'FSF)
   ;;  (local-set-key [menu-bar bibl] 'undefined))
   ((eq bibl-emacs-flavour 'Lucid)
    (require 'mode-motion)
    (setq mode-motion-hook 'mode-motion-highlight-line)))
  (run-hooks 'bibl-names-mode-hooks))


(if bibl-names-mode-map
    nil
  (setq bibl-names-mode-map (make-sparse-keymap))

  (if (not window-system)
      nil
    ;; Menu bar stuff.
  
    (cond
     ((eq bibl-emacs-flavour 'FSF)
      (require 'easymenu)
      (easy-menu-define bibl-lists-babble bibl-names-mode-map
			"Bibliography names menu."
			bibl-names-menu))
     ((eq bibl-emacs-flavour 'Lucid)
      (define-key bibl-names-mode-map 'button3 'bibl-names-lucid-menu)))

    (define-key bibl-names-mode-map
      (cond ((eq bibl-emacs-flavour 'FSF) [mouse-2])
	    ((eq bibl-emacs-flavour 'Lucid) 'button2))
      'bibl-names-mouse-select))
  
  (define-key bibl-names-mode-map " " 'bibl-names-find-record)
  (define-key bibl-names-mode-map "\C-c\C-c" 'bibl-names-find-record)
  (define-key bibl-names-mode-map "n" 'next-line)
  (define-key bibl-names-mode-map "p" 'previous-line))

;;; bibl-lists ends here
