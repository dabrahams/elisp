;;; mailcap.el --- mailcap parser

;; Copyright (C) 1997,1998 Free Software Foundation, Inc.

;; Author: MORIOKA Tomohiko <morioka@jaist.ac.jp>
;; Created: 1997/6/27
;; Keywords: mailcap, setting, configuration, MIME, multimedia

;; This file is part of SEMI (Spadework for Emacs MIME Interfaces).

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

;;; Code:

(require 'mime-def)


;;; @ comment
;;;

(defsubst mailcap-skip-comment ()
  (let ((chr (char-after (point))))
    (when (and chr
	       (or (= chr ?\n)
		   (= chr ?#)))
      (forward-line)
      t)))


;;; @ token
;;;

(defsubst mailcap-look-at-token ()
  (if (looking-at mime-token-regexp)
      (let ((beg (match-beginning 0))
	    (end (match-end 0)))
	(goto-char end)
	(buffer-substring beg end)
	)))


;;; @ typefield
;;;

(defsubst mailcap-look-at-type-field ()
  (let ((type (mailcap-look-at-token)))
    (if type
	(if (eq (char-after (point)) ?/)
	    (progn
	      (forward-char)
	      (let ((subtype (mailcap-look-at-token)))
		(if subtype
		    (cons (cons 'type (intern type))
			  (unless (string= subtype "*")
			    (list (cons 'subtype (intern subtype)))
			    )))))
	  (list (cons 'type (intern type)))
	  ))))


;;; @ field separator
;;;

(defsubst mailcap-skip-field-separator ()
  (let ((ret (looking-at "\\([ \t]\\|\\\\\n\\)*;\\([ \t]\\|\\\\\n\\)*")))
    (when ret
      (goto-char (match-end 0))
      t)))


;;; @ mtext
;;;

(defsubst mailcap-look-at-schar ()
  (let ((chr (char-after (point))))
    (if (and chr
	     (>= chr ? )
	     (/= chr ?\;)
	     (/= chr ?\\)
	     )
	(prog1
	    chr
	  (forward-char)))))

(defsubst mailcap-look-at-qchar ()
  (when (eq (char-after (point)) ?\\)
    (prog2
	(forward-char)
	(char-after (point))
      (forward-char))))

(defsubst mailcap-look-at-mtext ()
  (let ((beg (point)))
    (while (or (mailcap-look-at-qchar)
	       (mailcap-look-at-schar)))
    (buffer-substring beg (point))
    ))


;;; @ field
;;;

(defsubst mailcap-look-at-field ()
  (let ((token (mailcap-look-at-token)))
    (if token
	(if (looking-at "[ \t]*=[ \t]*")
	    (let ((value (progn
			   (goto-char (match-end 0))
			   (mailcap-look-at-mtext))))
	      (if value
		  (cons (intern token) value)
		))
	  (list (intern token))
	  ))))


;;; @ mailcap entry
;;;

(defun mailcap-look-at-entry ()
  (let ((type (mailcap-look-at-type-field)))
    (if (and type (mailcap-skip-field-separator))
	(let ((view (mailcap-look-at-mtext))
	      fields field)
	  (when view
	    (while (and (mailcap-skip-field-separator)
			(setq field (mailcap-look-at-field))
			)
	      (setq fields (cons field fields))
	      )
	    (nconc type
		   (list (cons 'view view))
		   fields))))))


;;; @ main
;;;

(defun mailcap-parse-buffer (&optional buffer order)
  "Parse BUFFER as a mailcap, and return the result.
If optional argument ORDER is a function, result is sorted by it.
If optional argument ORDER is not specified, result is sorted original
order.  Otherwise result is not sorted."
  (save-excursion
    (if buffer
	(set-buffer buffer))
    (goto-char (point-min))
    (let (entries entry)
      (while (progn
	       (while (mailcap-skip-comment))
	       (setq entry (mailcap-look-at-entry))
	       )
	(setq entries (cons entry entries))
	(forward-line)
	)
      (cond ((functionp order) (sort entries order))
	    ((null order) (nreverse entries))
	    (t entries)
	    ))))


(defcustom mailcap-file "~/.mailcap"
  "*File name of user's mailcap file."
  :group 'mime
  :type 'file)

(defun mailcap-parse-file (&optional filename order)
  "Parse FILENAME as a mailcap, and return the result.
If optional argument ORDER is a function, result is sorted by it.
If optional argument ORDER is not specified, result is sorted original
order.  Otherwise result is not sorted."
  (or filename
      (setq filename mailcap-file))
  (with-temp-buffer
    (insert-file-contents filename)
    (mailcap-parse-buffer (current-buffer) order)
    ))

(defun mailcap-format-command (mtext situation)
  "Return formated command string from MTEXT and SITUATION.

MTEXT is a command text of mailcap specification, such as
view-command.

SITUATION is an association-list about information of entity.  Its key
may be:

	'type		primary media-type
	'subtype	media-subtype
	'filename	filename
	STRING		parameter of Content-Type field"
  (let ((i 0)
	(len (length mtext))
	(p 0)
	dest)
    (while (< i len)
      (let ((chr (aref mtext i)))
	(cond ((eq chr ?%)
	       (setq i (1+ i)
		     chr (aref mtext i))
	       (cond ((eq chr ?s)
		      (let ((file (cdr (assq 'filename situation))))
			(if (null file)
			    (error "'filename is not specified in situation.")
			  (setq dest (concat dest
					     (substring mtext p (1- i))
					     file)
				i (1+ i)
				p i)
			  )))
		     ((eq chr ?t)
		      (let ((type (or (mime-type/subtype-string
				       (cdr (assq 'type situation))
				       (cdr (assq 'subtype situation)))
				      "text/plain")))
			(setq dest (concat dest
					   (substring mtext p (1- i))
					   type)
			      i (1+ i)
			      p i)
			))
		     ((eq chr ?\{)
		      (setq i (1+ i))
		      (if (not (string-match "}" mtext i))
			  (error "parse error!!!")
			(let* ((me (match-end 0))
			       (attribute (substring mtext i (1- me)))
			       (parameter (cdr (assoc attribute situation))))
			  (if (null parameter)
			      (error "\"%s\" is not specified in situation."
				     attribute)
			    (setq dest (concat dest
					       (substring mtext p (- i 2))
					       parameter)
				  i me
				  p i)
			    )
			  )))
		     (t (error "Invalid sequence `%%%c'." chr))
		     ))
	      ((eq chr ?\\)
	       (setq dest (concat dest (substring mtext p i))
		     p (1+ i)
		     i (+ i 2))
	       )
	      (t (setq i (1+ i)))
	      )))
    (concat dest (substring mtext p))
    ))


;;; @ end
;;;

(provide 'mailcap)

;;; mailcap.el ends here
