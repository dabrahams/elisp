;; *****************************************************************************
;;
;;  jam-mode.el
;;  Font-lock support for Jam files
;;
;;  Copyright (C) 2000, Eric Scouten
;;  Copyright (C) 1985, 1986 Free Software Foundation, Inc.
;;  Copyright (C) 2001 David brahams
;;  Started Sat, 05 Aug 2000
;;
;; *****************************************************************************
;;
;;  This is free software; you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation; either version 2, or (at your option)
;;  any later version.
;;
;;  jam-mode.el is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;  General Public License for more details.
;;
;;  You should have received a copy of the GNU General Public License
;;  along with GNU Emacs; see the file COPYING.  If not, write to
;;  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
;;
;; *****************************************************************************
;;
;;  To add font-lock support for Jam files, simply add the line
;;  (require 'jam-mode) to your .emacs file. Make sure generic-mode.el
;;  is visible in your load-path as well.
;;  
;; *****************************************************************************


;; Generic-mode is a meta-mode which can be used to define small modes
;; which provide basic comment and font-lock support. Jam-mode depends on
;; this mode.

(require 'generic)
(require 'cl)

(define-generic-mode 'jam-mode

  ; Jam comments always start with '#'
  (list ?# )

  ; Jam keywords (defined later)
  nil

  ; Extra stuff to colorize
  (list

    ; Jam keywords
	(generic-make-keywords-list
	 (list "actions" "bind" "case" "default" "else" "existing" "for" "if" "while" "module"
		   "ignore" "in" "include" "local" "on" "piecemeal" "quietly" "rule" "switch"
		   "together" "updated")
	 'font-lock-keyword-face)

	; Jam built-in variables
	(generic-make-keywords-list
	 (list
	  "JAMDATE" "JAMSHELL" "JAMUNAME" "JAMVERSION" "MAC" "NT" "OS" "OS2"
	  "OSPLAT" "OSVER" "UNIX" "VMS" "JAM_VERSION")
	 'font-lock-constant-face)

	; Jam built-in targets
	(generic-make-keywords-list
	 (list
	  "ALWAYS" "DEPENDS" "ECHO" "INCLUDES" "LEAVES" "LOCATE" "NOCARE"
	  "NOTFILE" "NOUPDATE" "SEARCH" "TEMPORARY" "IMPORT" "CALLER_MODULE" "SUBST")
	 'font-lock-builtin-face)

	; Jam built-in targets (warnings)
	(generic-make-keywords-list
	 (list
	  "EXIT")
	 'font-lock-warning-face)

	; Jambase rules
	(generic-make-keywords-list
	 (list
	  "Archive" "As" "Bulk" "Cc" "CcMv" "C\\+\\+" "Chgrp" "Chmod" "Chown" "Clean" "CreLib"
	  "Depends" "File" "Fortran" "GenFile" "GenFile1" "HardLink"
	  "HdrRule" "Install" "InstallBin" "InstallFile" "InstallInto" "InstallLib" "InstallMan"
	  "InstallShell" "Lex" "Library" "LibraryFromObjects" "Link" "LinkLibraries"
	  "Main" "MainFromObjects" "MakeLocate" "MkDir" "MkDir1" "Object" "ObjectC\\+\\+Flags"
	  "ObjectCcFlags" "ObjectHdrs" "Objects" "Ranlib" "RmTemps" "Setuid" "SubDir"
	  "SubDirC\\+\\+Flags" "SubDirCcFlags" "SubDirHdrs" "SubInclude" "Shell" "Undefines"
	  "UserObject" "Yacc" "Yacc1" "BULK" "FILE" "HDRRULE" "INSTALL" "INSTALLBIN" "INSTALLLIB"
	  "INSTALLMAN" "LIBRARY" "LIBS" "LINK" "MAIN" "SETUID" "SHELL" "UNDEFINES"
	  "addDirName" "makeCommon" "makeDirName" "makeGrist" "makeGristedName" "makeRelPath"
	  "makeString" "makeSubDir" "makeSuffixed" "unmakeDir")
	 'font-lock-function-name-face)
	
	; Jambase built-in targets
	(generic-make-keywords-list
	 (list
	  "all" "clean" "dirs" "exe" "files" "first" "install" "lib" "obj"
          "shell" "uninstall" "test")
	 'font-lock-builtin-face)

	; Jambase built-in variables
	(generic-make-keywords-list
	 (list
	  "ALL_LOCATE_TARGET" "AR" "ARFLAGS" "AS" "ASFLAGS" "AWK" "BCCROOT" "BINDIR" "CC" "CCFLAGS"
	  "C\+\+" "C\\+\\+FLAGS" "CHMOD" "CP" "CRELIB" "CW" "CWGUSI" "CWMAC" "CWMSL" "DOT" "DOTDOT"
	  "EXEMODE" "FILEMODE" "FORTRAN" "FORTRANFLAGS" "GROUP" "HDRGRIST" "HDRPATTERN" "HDRRULE"
	  "HDRS" "HDRSCAN" "HDRSEARCH" "INSTALL" "JAMFILE" "JAMRULES" "LEX" "LIBDIR" "LINK"
	  "LINKFLAGS" "LINKLIBS" "LOCATE_SOURCE" "LOCATE_TARGET" "LN" "MACINC" "MANDIR" "MKDIR"
	  "MODE" "MSLIB" "MSLINK" "MSIMPLIB" "MSRC" "MSVC" "MSVCNT" "MV" "NEEDLIBS" "NOARSCAN"
	  "OSFULL" "OPTIM" "OWNER" "RANLIB" "RCP" "RELOCATE" "RM" "RSH" "RUNVMS" "SEARCH_SOURCE"
	  "SED" "SHELLHEADER" "SHELLMODE" "SLASH" "SLASHINC" "SOURCE_GRIST" "STDHDRS" "STDLIBPATH"
	  "SUBDIR" "SUBDIRASFLAGS" "SUBDIRC\\+\\+FLAGS" "SUBDIRCCFLAGS" "SUBDIRHDRS" "SUBDIR_TOKENS"
	  "SUFEXE" "SUFLIB" "SUFOBJ" "UNDEFFLAG" "UNDEFS" "WATCOM" "YACC" "YACCFLAGS" "YACCFILES")
	 'font-lock-function-name-face)

     ; Jam variable references $(foo)
	'("$(\\([^ :\\[()\t\r\n]+\\)[)\\[:]" 1 font-lock-variable-name-face))

  ; Apply this mode to all files whose names start with "Jam".
  (list "[Jj]ambase$" "[Jj]amfile$" "[Jj]amrules$" "\\.jam$")

  ; Attach setup function so we can modify syntax table.
  (list 'jam-mode-setup-function 'jam-mode-run-hooks)

  ; Brief description
  "Generic mode for jam rules files")

 (defun jam-mode-setup-function ()
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?. "_")
  (modify-syntax-entry ?/ "_")
  (modify-syntax-entry ?\\ "\\")
  (modify-syntax-entry ?+ "w")
  (local-set-key ";" 'jam-mode-electric-semicolon)
  (local-set-key [return] 'jam-mode-newline-and-indent)
  (local-set-key "{" 'jam-mode-electric-open-brace)
  (local-set-key "}" 'jam-mode-electric-close-brace)
  (local-set-key "\M-{" 'jam-mode-electric-braces)
  (local-set-key "$" 'jam-mode-electric-dollar)
  (local-set-key [\C-f10] 'jam-debug-prev)
  (local-set-key [f10] 'jam-debug-next)
  (local-set-key [\S-f11] 'jam-debug-finish)
  (local-set-key [\C-\S-f11] 'jam-debug-caller)
  (local-set-key [f11] 'jam-debug-in)
;   (local-set-key "!" 'jam-mode-insert-punctuation)
;   (local-set-key "(" 'jam-mode-insert-punctuation)
;   (local-set-key "[" 'jam-mode-insert-punctuation)
;   (local-set-key ")" 'jam-mode-insert-punctuation)
;   (local-set-key "]" 'jam-mode-insert-punctuation)
;   (local-set-key "|" 'jam-mode-insert-double-punctuation)
;   (local-set-key "&" 'jam-mode-insert-double-punctuation)
  (local-set-key [tab] 'indent-for-tab-command)
  (setq fill-paragraph-function 'jam-mode-fill-paragraph)
  (make-local-variable 'indent-line-function)
  (setq indent-line-function 'jam-mode-indent-line)
   )

(defun jam-mode-run-hooks ()
  (run-hooks 'jam-mode-hook))

;; Stolen from emacs-lisp-mode.el, with slight modifications for reformatting comments
;;
(defun jam-mode-fill-paragraph (&optional justify)
  "Like \\[fill-paragraph], but handle Jam comments
If any of the current line is a comment, fill the comment or the
paragraph of it that point is in, preserving the comment's indentation
and initial hash marks."
  (interactive "P")
  (let (
	;; Non-nil if the current line contains a comment.
	has-comment

	;; Non-nil if the current line contains code and a comment.
	has-code-and-comment

	;; If has-comment, the appropriate fill-prefix for the comment.
	comment-fill-prefix
	)

    ;; Figure out what kind of comment we are looking at.
    (save-excursion
      (beginning-of-line)
      (cond

       ;; A line with nothing but a comment on it?
       ((looking-at "[ \t]*#[# \t]*")
	(setq has-comment t
	      comment-fill-prefix (buffer-substring (match-beginning 0)
						    (match-end 0))))

       ;; A line with some code, followed by a comment?  Remember that the
       ;; semi which starts the comment shouldn't be part of a string or
       ;; character.
       ((condition-case nil
	    (save-restriction
	      (narrow-to-region (point-min)
				(save-excursion (end-of-line) (point)))
	      (while (not (looking-at "#\\|$"))
		(skip-chars-forward "^#\n\"\\\\?")
		(cond
		 ((eq (char-after (point)) ?\\) (forward-char 2))
		 ((memq (char-after (point)) '(?\" ??)) (forward-sexp 1))))
	      (looking-at "#+[\t ]*"))
	  (error nil))
	(setq has-comment t has-code-and-comment t)
	(setq comment-fill-prefix
	      (concat (make-string (/ (current-column) 8) ?\t)
		      (make-string (% (current-column) 8) ?\ )
		      (buffer-substring (match-beginning 0) (match-end 0)))))))

    (if (not has-comment)
        ;; `paragraph-start' is set here (not in the buffer-local
        ;; variable so that `forward-paragraph' et al work as
        ;; expected) so that filling (doc) strings works sensibly.
        ;; Adding the opening paren to avoid the following sexp being
        ;; filled means that sexps generally aren't filled as normal
        ;; text, which is probably sensible.  The `;' and `:' stop the
        ;; filled para at following comment lines and keywords
        ;; (typically in `defcustom').
	(let ((paragraph-start (concat paragraph-start
                                       "\\|\\s-*[\(#:\"]")))
          (fill-paragraph justify))

      ;; Narrow to include only the comment, and then fill the region.
      (save-excursion
	(save-restriction
	  (beginning-of-line)
	  (narrow-to-region
	   ;; Find the first line we should include in the region to fill.
	   (save-excursion
	     (while (and (zerop (forward-line -1))
			 (looking-at "^[ \t]*#")))
	     ;; We may have gone too far.  Go forward again.
	     (or (looking-at ".*#")
		 (forward-line 1))
	     (point))
	   ;; Find the beginning of the first line past the region to fill.
	   (save-excursion
	     (while (progn (forward-line 1)
			   (looking-at "^[ \t]*#")))
	     (point)))

	  ;; Lines with only semicolons on them can be paragraph boundaries.
	  (let* ((paragraph-start (concat paragraph-start "\\|[ \t#]*$"))
		 (paragraph-separate (concat paragraph-start "\\|[ \t#]*$"))
		 (paragraph-ignore-fill-prefix nil)
		 (fill-prefix comment-fill-prefix)
		 (after-line (if has-code-and-comment
				 (save-excursion
				   (forward-line 1) (point))))
		 (end (progn
			(forward-paragraph)
			(or (bolp) (newline 1))
			(point)))
		 ;; If this comment starts on a line with code,
		 ;; include that like in the filling.
		 (beg (progn (backward-paragraph)
			     (if (eq (point) after-line)
				 (forward-line -1))
			     (point))))
	    (fill-region-as-paragraph beg end
				      justify nil
				      (save-excursion
					(goto-char beg)
					(if (looking-at fill-prefix)
					    nil
					  (re-search-forward comment-start-skip)
					  (point))))))))
    t))

(defun jam-quoted-p ()
  "Is point preceded by an odd number of backslashes?"
  (eq -1 (% (save-excursion (skip-chars-backward "\\\\")) 2)))

;; Formatting functions
;;
;;      Electric character insertions, etc. These take a very unsophisticated
;;      approach of hardwiring the indentation. Also, they may get confused
;;      about the corret indentation if you have quoted '#' characters in your
;;      Jam code.
(defun jam-mode-electric-close-brace ()
  (interactive "*")
  (let ((indentation
        (progn
          (delete-region (point)
                         (progn
                         (or (zerop (skip-chars-backward " \t"))
                             (if (jam-quoted-p)
                                 (forward-char)))
                         (point)))
          (if (equal (char-before) ?{ ) (current-indentation)
              (- (current-indentation) 4)))))
    (if (not (equal (point) (line-beginning-position)))
        (newline))
    (insert-string "}")
    (jam-mode-indent-line)
    (jam-mode-newline-and-indent)))

(defun jam-mode-mark-or-point ()
  "Return the mark if it is active, otherwise the point."
  (if mark-active (mark) (point)))

(defun jam-mode-selection ()
  "Return a pair [start . finish) delimiting the current selection"
  (let ((mark-or-point (jam-mode-mark-or-point)))
    (cons (min  mark-or-point (point))
          (max mark-or-point (point)))))

(defun jam-mode-insert-in-comment (c)
  (and (save-excursion (re-search-backward "#" (line-beginning-position) t))
       (progn (insert-char c 1) t)))
             
(defun jam-mode-electric-dollar (&optional adjacent)
  "Inserts a $() surrounding the adjacent word, or standalone if there
is no word adjacent to the point, leafing the cursor between the
parens. With a prefix argument, won't surround any adjacent word."
  (interactive "P")
  (or (jam-mode-insert-in-comment ?$)
      (let ((start (car (jam-mode-selection)))
            (finish (cdr (jam-mode-selection)))
            (line-start (line-beginning-position))
            (line-end (line-end-position)))
        (if (and (equal start finish) (not adjacent))
            (progn
              (while (and (> start line-start)
                          (find (char-syntax (char-before start)) '(?_ ?w)))
                (setq start (- start 1)))
        
              (while (and (< finish line-end)
                          (find (char-syntax (char-after finish)) '(?_ ?w)))
                (setq finish (+ finish 1)))
              ))
    (goto-char finish)
    (insert-string ")")
    
    (if (equal start finish) ;; leave the point inside the parens if they will be empty
    (progn
      (backward-char 1)
      (insert-string "$("))
    (save-excursion
      (goto-char start)
      (insert-string "$(")))
    )))

(defun jam-mode-electric-semicolon ()
  (interactive "*")
  (insert-string
   (save-excursion
     (let ((start (point)))
       (if (and (re-search-backward "^[^#]*[^ \t\n]" (line-beginning-position) t)
                (equal (match-end 0) start))
           " ;" ";")))))
          

(defun jam-mode-indent-line (&optional ignored)
  (interactive "*")
  (save-excursion
;;    (beginning-of-line)
;;    (re-search-forward "[ \t]*[]})]?" (line-end-position) t)
    (indent-line-to (jam-mode-indentation)))
  (skip-chars-forward " \t"))

(defun jam-mode-line-begins-with-close ()
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward " \t")
    (looking-at "[]})]")))
  
(defun jam-mode-line-begins-with-open ()
  (save-excursion
    (beginning-of-line)
    (skip-chars-forward " \t")
    (looking-at "[[({]")))
  
(defun jam-mode-base-indentation ()
  (save-excursion
    (if (progn (beginning-of-line) (skip-chars-forward " \t")
               (looking-at "[]})]"))
        (progn
          (forward-char 1)
          (forward-sexp -1)
          (current-indentation))
      ;; else
      (if (and (ignore-errors (progn (previous-line 1) (end-of-line) t))
               (re-search-backward "^[^#\n]*\\([][(){};]\\)" nil t))
          (progn
            (goto-char (match-beginning 1))
            (if (and (looking-at ";")
                     ;; (re-search-backward "^[^#\n]*\\([][}{)(]\\)" nil t)
                     (re-search-backward "^[^#\n]*\\([{}]\\)" nil t)
                     (equal (char-after (match-beginning 1)) ?{))
                ;; then
                (+ (current-indentation) 4)
              ;; else
              (+ (current-indentation)
                 (cond ((looking-at "{") 4)
                       ((looking-at "[[(]") 2)
                       (t 0)))))
        0)
      )
    ))

(defun jam-mode-indentation ()
    ;; find a line with some non-comment content
    (+ (jam-mode-base-indentation)
       (if (jam-mode-line-begins-with-close) 0
         (save-excursion
           (beginning-of-line)
           (skip-chars-forward " \t")
           
           (cond ((looking-at "{") 0)
                 
                 ((re-search-backward "^[ \t]*[^#\n]*\\([^# \t\n]\\)" nil t)
                  (progn (goto-char (match-beginning 1))
                         (if (looking-at "[[;({}]") 0 2)))
                 (t 0))
           ))))
        
    
(defun jam-mode-newline-and-indent ()
  (interactive "*")
  (newline)
  (jam-mode-indent-line))
    
(defun jam-mode-electric-braces ()
  (interactive "*")
  (let ((indentation (jam-mode-base-indentation)))
    (if (equal (current-indentation) (current-column))
        (indent-line-to indentation))
    (insert-string "{}")
    (backward-char)
    (newline)
    (newline)
    (indent-line-to indentation)
    (previous-line 1)
    (indent-to (+ indentation 4))))

(defun jam-mode-electric-open-brace ()
  (interactive "*")
  (let ((indentation (jam-mode-base-indentation)))
    (if (equal (current-indentation) (current-column))
        (indent-line-to indentation))
    (insert-string "{")
    (newline)
    (indent-line-to (+ indentation 4))))

(require 'compile)

(defun jam-debug-nesting ()
  (save-excursion
    (let ((result nil))
      (beginning-of-line)
      (search-forward ":>>")
      (let ((start (+ (point) 1)))
        (search-forward " ")
        (setq result (length (buffer-substring start (- (point) 1)))))
      result)))

(defun jam-debug-move (nesting line-function)
  ;; Abusing mark/point here for hilighting purposes. No time to figure out how
  ;; to do it "right"
  (deactivate-mark)
  (let ((line-form (list line-function 1)))
    (eval line-form)
    (while (> (jam-debug-nesting) nesting)
      (eval line-form)))
  (end-of-line)
  (set-mark (point))
  (beginning-of-line)
  (set-mark (mark t))
  )

(defun jam-debug-out (line-function)
  (jam-debug-move (- (jam-debug-nesting) 2) line-function))

(defun jam-debug-find-line ()
  (interactive)
  (beginning-of-line)
  (if (re-search-forward "^\\(.*\\):\\([0-9]+\\):" (line-beginning-position 2) t)
      (progn
        (end-of-line)
        (set-mark (point))
        (beginning-of-line)
        (set-window-start (get-buffer-window (current-buffer)) (point))
        (let*
            ((path (match-string 1))
             (line (string-to-number (match-string 2)))
             )
          
          (pop-to-buffer
           (compilation-find-file line
                                  (directory-file-name path)
                                  (file-name-directory path)))
          
          (goto-line line))
        )
    ))
  
(defun jam-debug-motion (form)
  (let ((in-jam-mode (and (eq major-mode 'generic-mode)
                          (eq generic-mode-name 'jam-mode))))
    (if in-jam-mode
        (switch-to-buffer-other-window (compilation-find-buffer)))
    (eval form)
    (if in-jam-mode
        (jam-debug-find-line))))
    
(defun jam-debug-next ()
  "go to next line in evaluation of current rule, or calling rule if no such line exists"
  (interactive)
  (jam-debug-motion
   '(jam-debug-move (jam-debug-nesting) 'next-line)))

(defun jam-debug-prev ()
  "go to next line in evaluation of current rule, or calling rule if no such line exists"
  (interactive)
  (jam-debug-motion
   '(jam-debug-move (jam-debug-nesting) 'previous-line)))

(defun jam-debug-finish ()
  "go to next line in caller of current rule, or its caller and so on if no such line exists"
  (interactive)
  (jam-debug-motion
   '(jam-debug-out 'next-line)))

(defun jam-debug-caller ()
  "go to previous line in caller of current rule, or its caller and so on if no such line exists"
  (interactive)
  (jam-debug-motion
   '(jam-debug-out 'previous-line)))

(defun jam-debug-in ()
  "go in to next rule call"
  (interactive)
  (jam-debug-motion
   '(progn
      (next-line 1)
      (end-of-line)
      (set-mark (point))
      (beginning-of-line)
      (set-mark (mark t)))))

(provide 'jam-mode)

;; jam-mode.el ends here
