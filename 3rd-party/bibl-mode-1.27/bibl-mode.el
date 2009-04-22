;; bibl-mode -- a major mode for maintaining bibliography files
;; Copyright (C) 1994 Bryan O'Sullivan

;; Author: Bryan O'Sullivan <bos@serpentine.com>
;; Keywords: bibliographies, databases, Internet
;; $Revision: 1.27 $
;; $Date: 1995/06/05 21:21:46 $
;; $Source: /archive/pub/bosullvn/elisp/bibl-mode/RCS/bibl-mode.el,v $

;; LCD Archive Entry:
;; bibl-mode|Bryan O'Sullivan|bos@serpentine.com|
;; Keep track of and access information on the World Wide Web|
;; $Date: 1995/06/05 21:21:46 $|$Revision: 1.27 $|
;; ftp.maths.tcd.ie:pub/bosullvn/elisp/bibl-mode.tar.gz|

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

;; We may require, in addition to reporter and easymenu, zero or more
;; of ange-ftp (or efs) or telnet.  See below.

(defconst bibl-maintainer-address "bug-bibl@serpentine.com"
  "The email address of the author.")

(defconst bibl-version (substring "$Revision: 1.27 $" 11 -2)
  "Current incarnation of bibliography mode.")

(defconst bibl-emacs-flavour
  (if (string-match "Lucid" emacs-version)
      'Lucid 'FSF)
  "The sort of Emacs under which we are running; if it ain't Lucid, it's FSF.")

(defconst bibl-file-format "1"
  "The most recent file format we understand.
If the format of a bibligraphy file is greater than this, anything can
happen.")

(defconst bibl-url-telnet "telnet"
  "The URL name for a telnet session.")

(defconst bibl-url-file "file"
  "The URL name for an ftp session.")


;; The most immediately user-useful variables.

(defvar bibl-mode-hooks nil
  "*A function or list of functions to be run on entering bibliography mode.")

(defvar bibl-names-mode-hooks nil
  "*Code to be run on entering bibliography names mode.")

(defvar bibl-file-name "~/.bibliography"
  "*The default bibliography file name.")

(defvar bibl-user-name (if user-mail-address
			   user-mail-address
			 (concat (user-login-name) "@" (system-name)))
  "*The name by which you wish to be known.

The value of this variable is used as your password for remote file
access using anonymous ftp.")

(defvar bibl-web-interface "TkWWW %s &"
  "*How to access information over the Web.
If a symbol, run the function with the symbol of that name, giving it
one argument, the URL to access.  For instance, if set to 'w3-fetch,
we look to use the W3 package.

If a string, we assume this is a command to be run.  In the string,
`%s' is replaced with the URL.  So, for example, if you want to run
TkWWW on a URL, set this variable to \"TkWWW %s &\".")

(defvar bibl-use-elisp 'both
  "*Use efs or ange-ftp and telnet.el instead of the Web browser.
Set to 'telnet to use only telnet.el, 'efs to use ange-ftp or efs, or
'both to use both.")

(defvar bibl-use-any-buffer t
  "*If t, allow more than one buffer to be used in bibl-mode at a time.
This means that pop-ups won't work any longer.  Set this to t and
`bibl-cache-keys' to nil to ensure no possibly unwanted effects on
your bibliography buffers.")

(defvar bibl-cache-keys nil
  "*Reduce computation by caching keys.
We do this by saving the bibliography buffer after generating a list of
names or keywords; if the buffer has been modified next time we want the
list, we know we have to generate it again.

You may not want to use this, since it saves the bibliography file.")

(defvar bibl-prompt-on-visit t
  "*Prompt for a file to visit upon running `\\[bibl-visit-bibliography]'.")

(defvar bibl-dont-fill nil
  "*If t, don't add any bibl-mode key binding tweakage for formatting.
Set this before you load bibl-mode, otherwise it will have no effect.")

(defvar bibl-indentation 4
  "*The preferred horizontal position of the first character on non-header lines.")


;; How we talk to other processes, if we do so at all.

(defvar bibl-send-mail-style nil
  "*Specifies which package should be used to send mail.
Should be 'vm, 'mh, 'mail, or nil (signifying guess).")

(defvar bibl-mail-subject-prompt t
  "*Prompt the user for a subject before sending mail.
If non-nil, the user is prompted; if a string, this is used as the initial
subject string.")

(defvar bibl-default-user "anonymous"
  "*User name to use when none is specified in a file name.
Takes precedence over the value of `ange-ftp-default-user', but
otherwise acts in the same way.  This will be updated as soon as I get
to use efs.")

(defvar bibl-best-guess "file"
  "*Type of URL to assume if none is given to
`bibl-find-resource-internal'.")


(defvar bibl-find-resource-edit t
  "*Allow the user to edit a resource before performing an action on it.
Should probably be enabled by default.")

(defvar bibl-fill-prefix "    "
  "*The string for filling to insert at the front row of a new line.")

(defvar menu-bar-bibl-menu nil
  "Menu keymap for bibliography submenu on file menu.")

(defvar bibl-mode-prefix-map nil
  "Prefix keymap for bibliography major mode.")

(defvar bibl-mode-map nil
  "Keymap for bibliography major mode.")

(defvar bibl-global-map nil
  "Global keymap for bibliography mode.")

(defvar bibl-names-mode-map nil
  "Keymap for bibliography names major mode.")


;; Variables to do with record entry names.

(defvar bibl-location-name "Location"
  "String used for URL paths in templates.")

(defvar bibl-path-regexp (concat bibl-location-name
				 ":[ \t]+\\([a-zA-Z]+\\):\\([^\n]*\\)$")
  "Regular expression which matches all supported network paths.
Do not mess with the last part, on pain of breaking something obscure
somewhere.")

(defvar bibl-mail-address-regexp
  "^\\(Author\\|Contact\\):[ \t]+\\([^\n]*\\)"
  "Regexp which matches record headers containing email addresses.")

(defconst bibl-record-fields
  (list "Name"
	"Keywords"
	"Description"
	bibl-location-name
	"Author"
	"Contact"
	"ISBN"
	"Publisher"
	"Date"
	"Record"
	"Updated")
  "List of fields in a standard record.
You can not change or add to this variable.  Instead, change the value
of `bibl-custom-record-fields' and `bibl-custom-grab-fields' (which see).")

(defvar bibl-custom-record-fields nil
  "*Custom user-defined fields for extending records.
Add to this as you wish, but be sure to remember to run
`\\[bibl-update-record-fields]' afterwards, otherwise bibl-mode may not
notice the changes you make.")

(defvar bibl-custom-record-hooks nil
  "*List of hooks to be run when a mouse click occurs on a user-defined field.
Each hook takes one argument, which is the event associated with the click.")

(defvar bibl-record-template nil
  "Empty template for a bibliography record.
Do not change this manually; instead, run `\\[bibl-update-record-fields]'.")

(defvar bibl-record-alist nil
  "Alist of template element names and template elements.
Do not change this manually; instead, run `\\[bibl-update-record-fields]'.")


;; Display things and completion things.

(defvar bibl-highlight-match 'underline
  "*Style in which to highlight a record if it matches a name or keyword.
Set to nil to turn highlighting off.  I find this feature useful, since
it can be hard to see what has been matched when you have several windows
and frames open at once.")

(defvar bibl-highlight-sit 5
  "*Length of time for which to sit before removing a highlight.")

(defvar bibl-completion-ignore-case t
  "*Whether or not to ignore case when completing names and keywords.")

(defvar bibl-completion-indexing 'both
  "*Choose whether to complete in `bibl-goto-record' by name or keyword.
Select 'name for name, 'keyword for keyword, and 'both for both.")


;; Set up autoloads.

(if (fboundp 'bibl-list-names)
    nil
  (autoload 'bibl-sort-buffer "bibl-lists"
    "Sort the contents of a bibliography mode buffer by name.
Uses the value of case-fold-search to determine whether or not to
ignore case while sorting." t)

  (autoload 'bibl-list-names "bibl-lists"
    "Make a list of the names found in a bibliography buffer.
Call with NO-POP set to something non-nil, or call interactively with
a prefix argument, to do this without any window shuffling." t)

  (autoload 'bibl-visit-list-names "bibl-lists"
    "Visit a bibliography buffer and list the record names to be found." t)
  
  (autoload 'bibl-list-keywords "bibl-lists"
    "Make a list of the keywords found in a bibliography buffer.
Call with NO-POP set to something non-nil, or call interactively with
a prefix argument, to work with less window shuffling." t)

  (autoload 'bibl-visit-list-keywords "bibl-lists"
    "Visit a bibliography buffer and list the record keywords to be found." t)
  
  (autoload 'bibl-visit-grab "bibl-grab"
    "Grab from the current buffer, visit bibliography file, create a record.
See the documentation for `bibl-visit-bibliography'."))


(defun bibl-update-record-fields ()
  "Run this function after you make changes to bibl-custom-record-fields.
It regenerates bibl-record-template and bibl-record-alist."
  (interactive "*")

  (setq bibl-record-template nil
	bibl-record-alist nil)
  (let ((elts (append bibl-record-fields bibl-custom-record-fields)))
    (while elts
      (let ((elt (car elts)))
	(setq bibl-record-template (concat
				    bibl-record-template (car elts) ": \n")
	      bibl-record-alist (append bibl-record-alist
					(list (cons elt
						    (concat elt ": \n"))))
	      elts (cdr elts))))))


(defun bibl-goto-record-start ()
  "Moves point to the start of the current record, and returns point.
Returns nil if no record is defined nearby."
  (beginning-of-line)
  (let ((r (looking-at "^Name: \\(.*\\)$")))
    (if r (point)
      (let ((p (re-search-backward "^Name: \\(.*\\)$" (bibl-buffer-min) t)))
	(if p p
	  (error "No current record!"))))))

(defmacro bibl-find-record-start ()
  "Return the start position of the current record, without moving point."
  '(save-excursion (bibl-goto-record-start)))

(defun bibl-goto-previous-header ()
  "Move point to the start of the header before the current one, and return point.
Returns nil if no header is found nearby."
  (let ((p (re-search-backward
	    "^\\([A-Za-z]+: \\|\\)$" (bibl-find-record-start) t)))
    (if p p
      (error "No current record!?"))))

(defun bibl-goto-next-header (&optional not-bol)
  "Move point to the start of the header before the current one, and return point.
Returns nil if no header is found nearby.  Prefix arg means leave point at the
end of the header, not the start."
  (let ((p (re-search-forward
	    "^\\([A-za-z]+: \\|\\)$" (bibl-find-record-end) t)))
    (if p
	(progn
	  (or not-bol
	      (beginning-of-line))
	  p)
      (error "No current record!?"))))

(defmacro bibl-goto-record-end ()
  "Move point to the end of the current record, and return its position."
  '(re-search-forward page-delimiter))

(defmacro bibl-find-record-end ()
  "Return the ending position of the current record, without affecting point."
  '(save-excursion (bibl-goto-record-end)))

(defun bibl-partial-expose ()
  "Pop up a partially-exposed bibliography mode buffer.
Does nothing if bibl-use-any-buffer is non-nil."
  (or bibl-use-any-buffer
      (pop-to-buffer (find-file-noselect bibl-file-name))))

(defun bibl-expose ()
  "Pop up a fully-exposed bibliography mode buffer.
Does nothing if bibl-use-any-buffer is non-nil."
  (or bibl-use-any-buffer
      (find-file bibl-file-name)))

(defun bibl-record-name ()
  "Return the name of the current record."
  (bibl-find-record-start)
  (buffer-substring (match-beginning 1) (match-end 1)))

(defalias 'bibl-buffer-min 'point-min)


(defun bibl-find-resource ()
  "Open the path pointed to by the current bibliography record.
If the path you choose is to a file or a telnet session, you may use
the file-finding and telnet facilities provided by Emacs by setting
`bibl-use-elisp' appropriately."
  (interactive)

  (save-excursion
    (bibl-partial-expose)
    (if (bibl-goto-record-start)
	(let ((search-limit (bibl-find-record-end))
	      alist)
	  (save-excursion
	    (while (< (point) search-limit)
	      (if (looking-at bibl-path-regexp)
		  (let ((type (buffer-substring (match-beginning 1)
						(match-end 1)))
			(data (buffer-substring (match-beginning 2)
						(match-end 2))))
		    (setq alist (append (list (list (concat type ":" data)
						    type data))
					alist))))
	      (forward-line 1))
	    (let ((l (length alist)))
	      (cond ((eq l 1)
		     (apply 'bibl-find-resource-internal (car alist)))
		    ((> l 1)
		     (let ((full (completing-read
				  "Link to use: " alist nil 'nice)))
		       (apply 'bibl-find-resource-internal
			      (assoc full alist))))
		    (t
		     (error (concat "No network resources listed for "
				    (bibl-record-name)))))))))))


(defun bibl-find-resource-internal (full &optional type data)
  "Internal code for finding a resource.

FULL must be a proper URL, and TYPE its type field (the bit before the
colon).  DATA must be the part after the TYPE field, excluding the
colon.  When called interactively, this function prompts for a URL to
find."
  (interactive
   (list (read-from-minibuffer "URL to find: ") nil nil))

  (if (string-match "^\\([a-zA-Z]+\\):\\(.*\\)" full)
      (progn
	(setq type (substring full (match-beginning 1) (match-end 1)))
	(setq data (substring full (match-beginning 2) (match-end 2)))))

  (cond
   ((and (string-match "^telnet" type)
	 (or (equal bibl-use-elisp 'telnet)
	     (equal bibl-use-elisp 'both)))
    (require 'telnet)
    (string-match "//?\\(.*\\)" data)
    (let ((host (substring data (match-beginning 1) (match-end 1))))
      (telnet (if bibl-find-resource-edit
		  (read-from-minibuffer
		   "Open telnet connection to host: "
		   host)
		host))))
   ((and (string-match "^\\(file\\|ftp\\)" type)
	 (or (equal bibl-use-elisp 'efs)
	     (equal bibl-use-elisp 'both)))
    ;; Commented out for efs beta testers.
    ;; (require 'ange-ftp)
    (let* ((ange-ftp-default-user bibl-default-user)
	   (path (if (string-match "//\\([^/]+\\)\\(.*\\)" data)
		     (concat "/" (substring data (match-beginning 1) (match-end 1))
			     ":" (substring data (match-beginning 2) (match-end 2)))
		   data)))
      (find-file (if bibl-find-resource-edit
		     (read-file-name "Find file: " path path)
		   path))))
   (t
    (cond
     ((stringp bibl-web-interface)
      (shell-command (format bibl-web-interface
			     full full full full full)))
     ((fboundp bibl-web-interface)
      (funcall bibl-web-interface full))
     (t
      (message (concat "Not accessing " full)))))))
  

(defun bibl-mark-record ()
  "Set mark to the beginning of the current record, and point at the end."
  (interactive)

  (bibl-partial-expose)
  (push-mark (bibl-goto-record-start))
  (bibl-goto-record-end))
       

(defun bibl-update-record ()
  "Update the time stamp (the `Record' field) on the current record."
  (interactive "*")
  (bibl-create-record t))


(defun bibl-create-record (&optional update)
  "Create a template for a new record.

You edit the fields of this record manually.  There is no need to
delete unused fields by hand once you are done -- just use
`bibl-tidy-record' (\\[bibl-tidy-record]).  Mark is pushed before the
record is created, so you can get back to where you were with
`\\[exchange-point-and-mark]'.

When called with a prefix argument, this function updates the time
stamp (the `Record' field) on the current record."
  (interactive "P")

  (bibl-partial-expose)
  (undo-boundary)
  (if update
      (save-excursion
	(bibl-goto-record-start)
	(if (re-search-forward "^Updated: " (bibl-find-record-end) 'foo)
	    (progn
	      (if (looking-at "$")
		  nil
		(kill-line))
	      (insert bibl-user-name " " (current-time-string)))
	  (insert "Updated: " bibl-user-name " " (current-time-string) "\n")))
    (push-mark)
    (goto-char (bibl-buffer-min))
    (let ((top (point)))
      (insert bibl-record-template "\n")
      (goto-char top)
      (if (re-search-forward "^Record: " (bibl-find-record-end) t)
	  (progn
	    (insert bibl-user-name " " (current-time-string))
	    (goto-char top)
	    (end-of-line))
	(error "Hey!  No time stamp! This is BAD!")))))


(defun bibl-delete-record ()
  "Delete the current record (the one under point)."
  (interactive "*")

  (bibl-partial-expose)
  (if (yes-or-no-p (format "Delete the record for %s? " (bibl-record-name)))
      (progn
	(undo-boundary)
	(delete-region (bibl-find-record-start) (bibl-find-record-end))
	(delete-char 1))))


(defun bibl-tidy-record ()
  "Tidy up the current record, removing empty entries.
Run this when you have finished filling out a template created with
`bibl-create-record'."
  (interactive "*")
  (save-excursion
    (undo-boundary)
    (bibl-goto-record-start)

    (while (not (looking-at page-delimiter))
      (if (looking-at "^[A-Za-z\\-]+:[ \t]+$")
	  (kill-line 1)
	(forward-line 1)))))


(defun bibl-extend-record (header)
  "Extend the current record by asking the user for an extension header."
  (interactive
   (list (let ((completion-ignore-case t))
	   (cdr (assoc (completing-read "Element: "
					bibl-record-alist nil 'nice)
		       bibl-record-alist)))))

  (bibl-partial-expose)
  (undo-boundary)
  (bibl-goto-record-end)
  (insert header)
  (backward-char))


(defun bibl-mail-contact (recipient &optional subject)
  "Send electronic mail to the contact associated with the current record.

If bibl-mail-subject-prompt is not nil, the user is prompted for a
subject for the mail message (the value of bibl-mail-subject-prompt is
used as the default if it is a string)."
  (interactive
   (save-excursion
     (if (bibl-goto-record-start)
	 (let ((search-limit (bibl-find-record-end)))
	   (if (re-search-forward bibl-mail-address-regexp
				  search-limit t)
	       (list (buffer-substring (match-beginning 2)
				       (match-end 2)))
	     (error (concat "No contact address given for "
			    (bibl-record-name))))))))
  (let ((type (or bibl-send-mail-style
		  (cond ((featurep 'vm) 'vm)
			((featurep 'mh-e) 'mh)
			(t 'mail)))))
    (setq subject (if bibl-mail-subject-prompt
		      (read-from-minibuffer
		       "Subject: "
		       (if (stringp bibl-mail-subject-prompt)
			   bibl-mail-subject-prompt
			 nil))))
    (cond
     ((eq type 'mh)
      (or (fboundp 'mh-send)
	  (autoload 'mh-send "mh-e"))
      (mh-send recipient "" subject))
     ((eq type 'vm)
      (cond ((not (fboundp 'vm-mail-internal))
	     (load-library "vm")	; 5.32++
	     (or (fboundp 'vm-mail-internal)
		 (load-library "vm-reply")))) ; 5.31--
      (vm-mail-internal (concat "mail to " recipient)
			recipient subject))
     ((or (eq type 'mail) (eq type 'rmail))
      (mail nil recipient subject))
     (t
      (error
       "bibl-send-mail-style must be vm, mh, or rmail")))))

;; The following few functions are adapted from latex.el, by Per
;; Abrahamsen.

(defun bibl-indent-line (&optional please-indent)
  "Indent the line containing point.

This function isn't intelligent\; if the first word on your line ends
with a `:', the line will not be indented.  Using a prefix argument
forces the line to be indented."

  (interactive "P")
  (let (untouched-p)
    (save-excursion
      (if (or please-indent
	      (/= (current-indentation) bibl-indentation))
	  (let ((beg (progn (beginning-of-line)
			    (point))))
	    (back-to-indentation)
	    (delete-region beg (point))
	    (if (or please-indent
		    (not (looking-at "^[A-Za-z]+:")))
		(indent-to bibl-indentation)
	      (setq untouched-p t)))
	(setq untouched-p t)))
    (or untouched-p
	(back-to-indentation))))

(defun bibl-fill-paragraph (prefix)
  "Fill and indent paragraph at or after point.
Prefix arg means justify as well."
  (interactive "*P")
  (save-excursion
    (bibl-goto-next-header)
    (or (bolp) (newline 1))
    (and (eobp) (open-line 1))
    (let ((end (point-marker))
	  (start (progn
		   (bibl-goto-previous-header)
		   (point))))
      (bibl-fill-region-as-paragraph start end prefix))))

(defun bibl-fill-region-as-paragraph (from to &optional justify-flag)
  "Fill region as one paragraph: break lines to fit fill-column.
Prefix arg means justify too.
From program, pass args FROM, TO and JUSTIFY-FLAG."
  (interactive "*r\nP")
  (save-restriction
    (goto-char from)
    (skip-chars-forward " \n")
    (bibl-indent-line)
    (beginning-of-line)
    (narrow-to-region (point) to)
    (setq from (point))
    
    ;; from is now before the text to fill,
    ;; but after any fill prefix on the first line.
    
    ;; Make sure sentences ending at end of line get an extra space.
    (goto-char from)
    (while (re-search-forward "[.?!][])\"']*$" nil t)
      (insert ? ))
    ;; Then change all newlines to spaces.
    (subst-char-in-region from (point-max) ?\n ?\ )
    ;; Flush excess spaces, except in the paragraph indentation.
    (goto-char from)
    (skip-chars-forward " \t")
    (while (re-search-forward "   *" nil t)
      (delete-region
       (+ (match-beginning 0)
	  (if (save-excursion
		(skip-chars-backward " ])\"'")
		(memq (preceding-char) '(?. ?? ?!)))
	      2 1))
       (match-end 0)))
    (goto-char (point-max))
    (delete-horizontal-space)
    (insert "  ")
    (goto-char (point-min))
    (let ((prefixcol 0))
      (while (< (point) to)
	(move-to-column (1+ fill-column))
	(if (>= (point) to)
	    nil
	  (skip-chars-backward "^ \n")
	  (if (if (zerop prefixcol)
		  (bolp)
		(>= prefixcol (current-column)))
	      (skip-chars-forward "^ \n")
	    (forward-char -1)))
	(delete-horizontal-space)
	(if (equal (preceding-char) ?\\)
	    (insert ? ))
	(insert ?\n)
	(bibl-indent-line)
	(setq prefixcol (current-column))
	(and justify-flag (not (eobp))
	     (progn
	       (forward-line -1)
	       (justify-current-line)
	       (forward-line 1)))
	)
      (goto-char (point-max))
      (delete-horizontal-space))))


(defun bibl-mouse-record (e)
  "Frob the record field under the mouse, depending on its type.
The actions are as follows:

Location	go to the given location
Record		update the time stamp on the current record
Updated		update the time stamp on the current record
\(Mail address\)	send mail to the people listed

If the field does not match any built-in field type, the value of
`bibl-custom-record-hooks' is run (if defined)."
  (interactive "@e")

  (or (eq major-mode 'bibl-mode)
      (error "Mode bogons!  Ack!"))

  (mouse-set-point e)
  (save-excursion
    (beginning-of-line)
    (or (looking-at "^\\([a-zA-Z]+\\):[ \t]+\\([^\n]*\\)$")
	(error ""))
    (let ((line (buffer-substring (match-beginning 0) (match-end 0)))
	  (type (buffer-substring (match-beginning 1) (match-end 1)))
	  (data (buffer-substring (match-beginning 2) (match-end 2))))
      (cond
       ((equal type "Location")
	(bibl-find-resource-internal data))
       ((string-match "Record\\|Updated" type)
	(bibl-update-record))
       ((string-match bibl-mail-address-regexp line)
	(bibl-mail-contact data))
       (t
	(if bibl-custom-record-hooks
	    (run-hook-with-args 'bibl-custom-record-hooks e)
	  (error (format "No action associated with a %s element"
			 type))))))))
    

(defun bibl-goto-record ()
  "Go to a record, indexed by name or by keyword."
  (interactive)

  (if bibl-use-any-buffer
      (or (eq major-mode 'bibl-mode)
	  (error "Current buffer not in bibliography mode!"))
    (set-buffer
     (find-file-noselect bibl-file-name)))
  
  (goto-char (bibl-buffer-min))
  (search-forward
   (save-excursion
     (let ((completion-ignore-case bibl-completion-ignore-case)
	   (old-buffer (current-buffer))
	   buffers completion-alist)

       (cond ((eq bibl-completion-indexing 'keyword)
	      (setq buffers '("*Keywords*")))
	     ((eq bibl-completion-indexing 'name)
	      (setq buffers '("*Names*")))
	     (t
	      (setq buffers '("*Names*" "*Keywords*"))))

       (if (or (eq bibl-completion-indexing 'keyword)
	       (eq bibl-completion-indexing 'both))
	   (bibl-list-keywords t))
       (if (or (eq bibl-completion-indexing 'name)
	       (eq bibl-completion-indexing 'both))
	   (bibl-list-names t))

       (while buffers
	 (set-buffer (car buffers))
	 (goto-char (point-min))
	 (while (looking-at "^.")
	   (let ((pos (point)))
	     (forward-line 1)
	     (backward-char 1)
	     (setq completion-alist (append completion-alist
					    (list (cons (buffer-substring
							 pos (point))
							nil))))
	     (forward-char 1)))
	 (setq buffers (cdr buffers)))
       (completing-read "Find record: " completion-alist nil 'nice))))
  (bibl-goto-record-start)
  (pop-to-buffer (current-buffer)))


;; Suggested by Karl Fogel <kfogel@cs.oberlin.edu>.

;;;###autoload
(defun bibl-visit-bibliography (file)
  "Visit a bibliography file.
Uses the value of `bibl-file-name' as a default guess if run
interactively.  If `bibl-prompt-on-visit' is t, asks the user to
confirm the filename if called interactively."
  (interactive
   (list
    (if bibl-prompt-on-visit
	(read-file-name "Visit bibliography file: "
			bibl-file-name bibl-file-name)
      bibl-file-name)))
  (find-file file))


;;;###autoload
(defun bibl-visit-create ()
  "Visit a bibliography file and create a new record.
See the documentation for `bibl-visit-bibliography'."
  (interactive)

  (call-interactively 'bibl-visit-bibliography)
  (bibl-create-record))


;;;###autoload
(defun bibl-visit-goto ()
  "Visit a bibliography file and go to some record.
See the documentation for `bibl-visit-bibliography' and
`bibl-goto-record'."
  (interactive)

  (call-interactively 'bibl-visit-bibliography)
  (bibl-goto-record))


(defun bibl-buffer ()
  "Return some buffer which is visiting a bibliography file.  Don't select."
  (interactive)
  
  (save-excursion
     (save-window-excursion
       (call-interactively 'bibl-visit-bibliography)
       (current-buffer))))


;;;###autoload
(defun bibl-mode ()
  "Major mode for editing bibliography files.

By default, we only handle one such buffer at a time (its name should
be in bibl-file-name).  If you want to use more than one buffer in
bibliography mode at once, set `bibl-use-any-buffer' to t.  Note that
you will have to use bibliography mode commands from within
bibliography mode buffers in that case; they won't work just anywhere
any longer.

Page delimiter definitions have been changed so that the page movement
commands (\\[forward-page] and \\[backward-page]) hop between records.

The mode-specific key bindings are as follows:

\\{bibl-mode-prefix-map}
To access the global key bindings, put a line such as the following in
your `.emacs':
  (global-set-key \"\\Cb\" 'bibl-global-map)
Once bound to something in this way, the global key bindings go like
this:

\\{bibl-global-map}
Entry to this mode causes `bibl-mode-hooks' to be run."
  (interactive)

  (or bibl-use-any-buffer
      (find-file bibl-file-name))
  
  (kill-all-local-variables)
  (indented-text-mode)
  (bibl-update-record-fields)
  (setq major-mode 'bibl-mode
	mode-name "Bibliography"
	fill-prefix bibl-fill-prefix)

  (make-local-variable 'require-final-newline)
  (make-local-variable 'page-delimiter)
  (setq require-final-newline t
	page-delimiter "^[ \t\f\n]*$")

  (use-local-map bibl-mode-prefix-map)
  ;; (if (eq bibl-emacs-flavour 'FSF)
  ;;    (local-set-key [menu-bar bibl] 'undefined))
  (goto-char (point-min))

  (if (eq (point-min) (point-max))
      (insert
       (concat
	"File format "
	bibl-file-format ".  The mode of this bibliography is -*- bibl -*-.
Comments go here.  Please leave the first line and the form feed intact.
\f\n"))
    (if (looking-at "^File format \\([0-9]+\\)")
	(if (> (string-to-int (buffer-substring (match-beginning 1)
						   (match-end 1)))
	       (string-to-int bibl-file-format))
	    (error "File format not recognised")
	  (re-search-forward "\f\n"))
      (message "No file format information present!  Winging it ...")))
  (narrow-to-region (point) (point-max))
  (run-hooks 'bibl-mode-hooks))

  
(defun bibl-submit-bug-report ()
  "*Submit a bug report, with pertinent information, to the author."
  (interactive)

  (require 'reporter)

  (let ((reporter-mailer '(mail)))
    (reporter-submit-bug-report
     bibl-maintainer-address
     (concat "bibl-mode " bibl-version)
     '(bibl-mode-hooks
       bibl-names-mode-hooks
       bibl-file-name
       bibl-user-name
       bibl-web-interface
       bibl-use-any-buffer
       bibl-cache-keys
       bibl-send-mail-style
       bibl-mail-subject-prompt
       bibl-default-user
       bibl-best-guess
       bibl-use-elisp
       bibl-find-resource-edit
       bibl-fill-prefix
       bibl-location-name
       bibl-path-regexp
       bibl-mail-address-regexp
       bibl-record-fields
       bibl-custom-record-fields
       bibl-prompt-on-visit
       bibl-record-template
       bibl-record-alist
       bibl-highlight-match
       bibl-highlight-sit
       bibl-completion-ignore-case
       bibl-completion-indexing
       bibl-mode-prefix-map
       bibl-mode-map
       bibl-names-mode-map
       bibl-emacs-flavour)
     nil
     nil
     "Please change the Subject header to a concise bug description.

Remember to cover the basics, that is, what you expected to happen and
what in fact did happen.")
    (save-excursion
      (goto-char (point-min))
      (mail-position-on-field "Subject")
      (beginning-of-line)
      (delete-region (point) (progn (forward-line) (point)))
      (insert (concat "Subject: bibl-mode " bibl-version
		      " is causing problems again\n")))))


;; Menu support for Lucid and FSF Emacs.

(defconst bibl-mode-menu
  '("Bibliography"
    ["Visit bibliography file"	bibl-visit-bibliography t]
    ["Go to record"		bibl-goto-record t]
    ["Mark record"		bibl-mark-record t]
    ["List by name"		bibl-list-names t]
    ["List by keyword"		bibl-list-keywords t]
    "----"
    ["Create new record"	bibl-create-record t]
    ["Sort buffer"		bibl-sort-buffer t]
    ["Extend record"		bibl-extend-record t]
    ["Delete"			bibl-delete-record t]
    ["Update"			bibl-update-record t]
    ["Tidy up"			bibl-tidy-record t]
    "----"
    ["Mail contact"		bibl-mail-contact t]
    ["Find resource"		bibl-find-resource t])
  "Menu for bibliography mode.")


(defconst bibl-lucid-file-menu
  '(["Visit bibliography file"	bibl-visit-bibliography t]
    ["Create new record"	bibl-visit-create t]
    ["Grab from current"	bibl-visit-grab t]
    ["Goto record"		bibl-visit-goto t]
    ["List by name"		bibl-visit-list-names t]
    ["List by keyword"		bibl-visit-list-keywords t])
  "File menu for bibliography mode.")


(defun bibl-lucid-menu (e)
  (interactive "@e")
  (popup-menu bibl-mode-menu))


(setq bibl-mode-prefix-map (make-sparse-keymap)
      bibl-mode-map (make-sparse-keymap))

(if (not window-system)
    nil
  ;; Set up the global menu bar.

  (require 'easymenu)

  (cond
   ((eq bibl-emacs-flavour 'FSF)
    (setq menu-bar-bibl-menu (make-sparse-keymap "Bibliography functions."))
  
    (define-key menu-bar-file-menu [bibl]
      (cons "Bibliography" menu-bar-bibl-menu))
  
    (define-key menu-bar-bibl-menu [list-names]
      '("List by name" . bibl-visit-list-names))
    (define-key menu-bar-bibl-menu [list-keywords]
      '("List by keyword" . bibl-visit-list-keywords))
    (define-key menu-bar-bibl-menu [goto]
      '("Go to record" . bibl-visit-goto))
    (define-key menu-bar-bibl-menu [grab]
      '("Grab from current" . bibl-visit-grab))
    (define-key menu-bar-bibl-menu [create]
      '("Create new record" . bibl-visit-create))
    (define-key menu-bar-bibl-menu [visit]
      '("Visit bibliography file" . bibl-visit-bibliography))

    (easy-menu-define bibl-babble bibl-mode-prefix-map
		      "Bibliography menu."
		      bibl-mode-menu))
   ((eq bibl-emacs-flavour 'Lucid)
    (add-menu '("File") "Bibliography" bibl-lucid-file-menu)
    (define-key bibl-mode-prefix-map 'button3 'bibl-lucid-menu)))

  ;; A references menu.
  
  (define-key bibl-mode-prefix-map
    (cond ((eq bibl-emacs-flavour 'FSF) [C-mouse-2])
	  ((eq bibl-emacs-flavour 'Lucid) 'button2))
    'bibl-mouse-record))

(define-key bibl-mode-prefix-map "\C-c" bibl-mode-map)
(if bibl-dont-fill
    nil
  (define-key bibl-mode-prefix-map "\C-i" 'bibl-indent-line)
  (define-key bibl-mode-prefix-map "\M-\C-q" 'bibl-fill-paragraph))
(define-key bibl-mode-map "\C-b" 'bibl-sort-buffer)
(define-key bibl-mode-map "\C-c" 'bibl-create-record)
(define-key bibl-mode-map "\C-d" 'bibl-delete-record)
(define-key bibl-mode-map "\C-f" 'bibl-find-resource)
(define-key bibl-mode-map "\C-k" 'bibl-list-keywords)
(define-key bibl-mode-map "\C-m" 'bibl-mark-record)
(define-key bibl-mode-map "\C-n" 'bibl-list-names)
(define-key bibl-mode-map "\C-o" 'bibl-goto-record)
(define-key bibl-mode-map "\C-r" 'bibl-submit-bug-report)
(define-key bibl-mode-map "\C-s" 'bibl-mail-contact)
(define-key bibl-mode-map "\C-t" 'bibl-tidy-record)
(define-key bibl-mode-map "\C-u" 'bibl-update-record)
(define-key bibl-mode-map "\C-x" 'bibl-extend-record)

;;;###autoload
(define-prefix-command 'bibl-global-map)
;;;###autoload
(define-key bibl-global-map "c" 'bibl-visit-create)
;;;###autoload
(define-key bibl-global-map "g" 'bibl-visit-grab)
;;;###autoload
(define-key bibl-global-map "k" 'bibl-visit-list-keywords)
;;;###autoload
(define-key bibl-global-map "n" 'bibl-visit-list-names)
;;;###autoload
(define-key bibl-global-map "o" 'bibl-visit-goto)
;;;###autoload
(define-key bibl-global-map "v" 'bibl-visit-bibliography)


(provide 'bibl-mode)

;;; bibl-mode ends here
