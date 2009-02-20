;; bibl-grab -- part of bibl-mode
;; Copyright (C) 1994 Bryan O'Sullivan

;; Author: Bryan O'Sullivan <bos@serpentine.com>
;; Keywords: bibliographies, databases, Internet
;; $Revision: 1.6 $
;; $Date: 1995/05/27 15:32:23 $
;; $Source: /archive/pub/bosullvn/elisp/bibl-mode/RCS/bibl-grab.el,v $

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

;; COMMENTARY:

;; This code is derived from code and suggestions submitted by Ray
;; Nickson <nickson@cs.uq.oz.au>, to whom much thanks.

;; Just at the moment, it is a little indiscriminatory in its
;; operation.  I am happy with its current behaviour; your mileage may
;; vary.

(require 'bibl-mode)

(defconst bibl-grab-fields
  (list '("Name" "\\(Name\\|Subject\\)" 2)
	'("Keywords")
	'("Description" "Description" 1 fill-region-as-paragraph)
	(list bibl-location-name)
	'("Author")
	'("Contact" "\\(From\\|Contact\\|Sender\\)" 2)
	'("ISBN")
	'("Publisher")
	'("Date")
	'("Record")
	'("Updated"))
  "Alist of fields which may be grabbed from a mail message or news article.
See the documentation for `bibl-grab-custom-fields' for details.")


(defvar bibl-custom-grab-fields nil
  "*Alist of user-settable fields which may be grabbed from mail or news.

The first element should be the bibliography field name (see
`bibl-custom-record-fields').  The second, if present, should be a
regexp to to the matching.  The third, if present, should be the
subexpression of the regexp to copy.  The fourth member of each list,
if present, should be a function which is run on the grabbed text,
once it has been transferred to the bibliography mode buffer.")


(defvar bibl-grab-start-regexp "^;*\\s-*"
  "*Partial regexp which matches the possible start of a record.
Lines starting with this regexp possibly begin record entries in
non-bibliography buffers, which we may try to grab.  See also
`bibl-grab-tail-regexp', between this and which you can compose
several (sub)expressions to match.")


(defvar bibl-grab-end-regexp ":\\s-*\\(.*\\)$"
  "*Partial regexp which matches the part of a record after the identifier.
Lines ending with this regexp possibly end record entries in
non-bibliography buffers, which we may try to grab.")


(defvar bibl-grab-default-subexp 1
  "*Subexpression of a matched regexp to use by default, if none is given.")


;;;###autoload
(defun bibl-visit-grab (&optional from-here)
  "Grab from the current buffer, visit bibliography file, create a record.
If called with a prefix argument, search for record entries from
point, rather than from the top of the current buffer.

See the documentation for `bibl-visit-bibliography' for more details."
  (interactive "P")

  (let ((buf (current-buffer))
	(bibuf (bibl-buffer))
	(hdrs (append bibl-grab-fields bibl-custom-grab-fields))
	(bibl-prompt-on-visit nil))
    (set-buffer bibuf)
    (bibl-create-record)
    (set-buffer buf)
    (if from-here
	nil
      (goto-char (point-min)))
    (while hdrs
      (let* ((hdr (car hdrs))
	     (field (car hdr))
	     (regexp (concat bibl-grab-start-regexp
			     (if (>= (length hdr) 2)
				 (car (cdr hdr))
			       field)
			     bibl-grab-end-regexp))
	     (subexp (if (>= (length hdr) 3)
			 (car (cdr (cdr hdr)))
		       bibl-grab-default-subexp))
	     (hooks (and (>= (length hdr) 4)
			 (car (cdr (cdr (cdr hdr)))))))
	(bibl-grab-field field regexp subexp hooks))
      (setq hdrs (cdr hdrs)))
    (pop-to-buffer bibuf)))


(defun bibl-grab-field-set-buffer ()
  "Frob the current buffer before grabbing a field.
If we are in a mail or news summary buffer, jump to the message body
buffer before continuing."
  (let ((buf-name (buffer-name)))
    (cond
     ((string-match "^.*\\s-Summary" buf-name)	; VM
      (set-buffer (substring buf-name (match-beginning 1) (match-end 1))))
     ((string-match "^\\+" buf-name)		; mh-e
      (set-buffer (concat "show-" buf-name)))
     ((string= buf-name "*Summary*")		; GNUS
      (set-buffer "*Article*")))))


(defun bibl-grab-field (field regexp subexp &optional hook)
  "Grab a value for a bibliography FIELD from the current buffer.

Look from point onwards for a match for REGEXP: the SUBEXP'th
parenthesized subexpression in the match is the value to grab.  If the
text is copied from the region and optional arg HOOK is non-nil, run
the given hooks with two arguments, giving the start and end of the
copied region.

Hack: call bibl-grab-field-set-buffer first."
  (let ((val nil)
	(fail nil))
    (save-excursion
      (bibl-grab-field-set-buffer)
      (setq val
	    (save-excursion
	      (if (re-search-forward regexp nil t)
		  (buffer-substring (match-beginning subexp)
				    (match-end subexp))
		(setq fail t))))
      (pop-to-buffer (bibl-buffer))
      (goto-char (bibl-buffer-min))
      (if fail
          nil
        (if (not (re-search-forward (concat "^" field ": $") nil t))
            (error "Create empty entry first!")
          (let ((pt (progn (end-of-line nil) (point))))
            (insert val)
            (run-hook-with-args hook pt (point))))))))

;;; bibl-grab ends here
