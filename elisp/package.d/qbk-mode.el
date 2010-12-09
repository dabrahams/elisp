;; Copyright David Abrahams 2006. Would be distributed under the Boost
;; Software License, Version 1.0. (See accompanying file
;; LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt),
;; except that the boost license is overriden by the GPL until I strip
;; out all the boilerplate I stole from rst-mode to get me started.

;; Portions of this code Copyright 2003 Stefan Merten <smerten@oekonux.de>
;; 
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

(require 'regexp-opt)
(defvar qbk-mode-hook nil)

(defvar qbk-mode-map
  (let ((qbk-mode-map (copy-keymap text-mode-map)))
    (define-key qbk-mode-map "\C-j" 'newline-and-indent) qbk-mode-map)
  "Keymap for QBK major mode")

(add-to-list 'auto-mode-alist '("\\.qbk\\'" . qbk-mode))

(defvar qbk-mode-abbrev-table nil
 "Abbrev table used while in qbk mode.")
(define-abbrev-table 'qbk-mode-abbrev-table ())

(defvar qbk-mode-syntax-table nil
  "Syntax table used while in qbk mode.")

(unless qbk-mode-syntax-table
  (setq qbk-mode-syntax-table (make-syntax-table text-mode-syntax-table))
  (modify-syntax-entry ?$ "." qbk-mode-syntax-table)
  ;; We only want to find [ and ] by default
  (dolist (c '( ?( ?) ?{ ?} )) (modify-syntax-entry c "." qbk-mode-syntax-table))
  (modify-syntax-entry ?' "." qbk-mode-syntax-table)
  (modify-syntax-entry ?( "." qbk-mode-syntax-table)
  (modify-syntax-entry ?) "." qbk-mode-syntax-table)
  (modify-syntax-entry ?$ "." qbk-mode-syntax-table)
  (modify-syntax-entry ?% "." qbk-mode-syntax-table)
  (modify-syntax-entry ?& "." qbk-mode-syntax-table)
  (modify-syntax-entry ?' "." qbk-mode-syntax-table)
  (modify-syntax-entry ?* "." qbk-mode-syntax-table)
  (modify-syntax-entry ?+ "." qbk-mode-syntax-table)
  (modify-syntax-entry ?. "_" qbk-mode-syntax-table)
  (modify-syntax-entry ?/ "." qbk-mode-syntax-table)
  (modify-syntax-entry ?< "." qbk-mode-syntax-table)
  (modify-syntax-entry ?= "." qbk-mode-syntax-table)
  (modify-syntax-entry ?> "." qbk-mode-syntax-table)
  (modify-syntax-entry ?\\ "\\" qbk-mode-syntax-table)
  (modify-syntax-entry ?| "." qbk-mode-syntax-table)
  )

(defgroup qbk-faces nil "Faces used in Qbk Mode"
  :group 'qbk
  :group 'faces
  :version "21.1")

(defcustom qbk-block-face 'font-lock-keyword-face
  "All syntax marking up a special block"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-external-face 'font-lock-type-face
  "Field names and interpreted text"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-definition-face 'font-lock-function-name-face
  "All other defining constructs"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-directive-face
  ;; XEmacs compatibility
  (if (boundp 'font-lock-builtin-face)
      'font-lock-builtin-face
    'font-lock-preprocessor-face)
  "Directives and roles"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-comment-face 'font-lock-comment-face
  "Comments"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-emphasis1-face
  ;; XEmacs compatibility
  (if (facep 'italic)
      ''italic
    'italic)
  "Simple emphasis"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-replaceable-face 'qbk-replaceable-face
  "Replaceable text"
  :group 'qbk-faces
  :type '(face))

(defface qbk-replaceable-face
  ;; based on font lock variable name face.  Is there a way to create a modified face?
  '((((class grayscale) (background light))
     (:foreground "Gray90" :weight bold :slant italic))
    (((class grayscale) (background dark))
     (:foreground "DimGray" :weight bold :slant italic))
    (((class color) (min-colors 88) (background light)) (:foreground "DarkGoldenrod" :slant italic))
    (((class color) (min-colors 88) (background dark)) (:foreground "LightGoldenrod" :slant italic))
    (((class color) (min-colors 16) (background light)) (:foreground "DarkGoldenrod" :slant italic))
    (((class color) (min-colors 16) (background dark)) (:foreground "LightGoldenrod" :slant italic))
    (((class color) (min-colors 8)) (:foreground "yellow" :weight light :slant italic))
    (t (:weight bold :slant italic)))
  "Quickbook mode face used to highlight replaceable text."
  :group 'qbk-faces)

(defcustom qbk-emphasis2-face
  ;; XEmacs compatibility
  (if (facep 'bold)
      ''bold
    'bold)
  "Double emphasis"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-underline-face
  ;; XEmacs compatibility
  (if (facep 'underline)
      ''underline
    'underline)
  "Underlined"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-strikethrough-face
  ;; XEmacs compatibility
  (if (facep 'highlight-changes-delete)
      ''highlight-changes-delete
    'highlight-changes-delete)
  "Strikethrough"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-literal-face 'font-lock-string-face
  "Literal text"
  :group 'qbk-faces
  :type '(face))

(defcustom qbk-reference-face 'font-lock-variable-name-face
  "References to a definition"
  :group 'qbk-faces
  :type '(face))

;; Faces for displaying items on several levels; these definitions define
;; different shades of grey where the lightest one is used for level 1
(defconst qbk-level-face-max 6
  "Maximum depth of level faces defined")
(defconst qbk-level-face-base-color "grey"
  "The base color to be used for creating level faces")
(defconst qbk-level-face-base-light 85
  "The lightness factor for the base color")
(defconst qbk-level-face-format-light "%2d"
  "The format for the lightness factor for the base color")
(defconst qbk-level-face-step-light -7
  "The step width to use for next color")

;; Define the faces
(let ((i 1))
  (while (<= i qbk-level-face-max)
    (let ((sym (intern (format "qbk-level-%d-face" i)))
	  (doc (format "Face for showing section title text at level %d" i))
	  (col (format (concat "%s" qbk-level-face-format-light)
		       qbk-level-face-base-color
		       (+ (* (1- i) qbk-level-face-step-light)
			  qbk-level-face-base-light))))
      (make-empty-face sym)
      (set-face-doc-string sym doc)
      (set-face-background sym col)
      (set sym sym)
    (setq i (1+ i)))))

(defcustom qbk-adornment-faces-alist
  '((1 . qbk-level-1-face)
    (2 . qbk-level-2-face)
    (3 . qbk-level-3-face)
    (4 . qbk-level-4-face)
    (5 . qbk-level-5-face)
    (6 . qbk-level-6-face)
    (t . font-lock-keyword-face)
    (nil . font-lock-keyword-face))
  "Provides faces for the various adornment types. Key is a number (for the
section title text of that level), t (for transitions) or nil (for section
title adornment)."
  :group 'qbk-faces
  :type '(alist :key-type (choice (integer :tag "Section level")
				  (boolean :tag "transitions (on) / section title adornment (off)"))
		:value-type (face)))



(defun qbk-mode ()
  "Major mode for editing quickbook documents.

You may customize `qbk-mode-lazy' to switch font-locking of blocks.

\\{qbk-mode-map}
Turning on `qbk-mode' calls the normal hooks `text-mode-hook' and
`qbk-mode-hook'."
  (interactive)
  (kill-all-local-variables)

  ;; Maps and tables
  (use-local-map qbk-mode-map)
  (setq local-abbrev-table qbk-mode-abbrev-table)
  (set-syntax-table qbk-mode-syntax-table)

  ;; Font lock
  (set (make-local-variable 'font-lock-defaults)
       '(qbk-font-lock-keywords-function
	 t nil nil nil
	 (font-lock-multiline . t)
	 (font-lock-mark-block-function . mark-paragraph)))

  ;; Names and hooks
  (setq mode-name "QBK")
  (setq major-mode 'qbk-mode)
  (run-hooks 'text-mode-hook)
  (run-hooks 'qbk-mode-hook)
  )

(defun qbk-not-char-re ( char )
  "Returns a regular expression that matches a string consisting
of anything that is not CHAR or backslash-escaped instances of
CHAR."
  (let ((c (string char)))
    (concat "\\(?:[^" c "\\]\\|\\\\" c "\\)"))
  )

(defconst qbk-block-end-re "[:blank:]*\n[:blank:]*\n")

(defconst qbk-escape-tail-re
  (let ((not-quote-re (qbk-not-char-re ?')))
    (concat "'\\(" not-quote-re "*\\(?:''?" not-quote-re  "+\\)*\\)'''"))
  "A regular expression that matches everything but the first two
characters of quickbook's '''...''' escape blocks.  The first
match group captures the characters between the triple quotes."
)

(defconst qbk-escape-re
  (concat "''" qbk-escape-tail-re)
  "A regular expression that matches quickbook's '''...''' escape blocks.
The first match group captures the characters between the triple
quotes."
  )

(defconst qbk-code-block-re
  (let ((not-backquote-re (qbk-not-char-re ?`)))
    (concat "``\\(" not-backquote-re "*\\(?:`?" not-backquote-re  "+\\)*\\)``"))
  "A regular expression that matches quickbook's ``...`` code blocks.
The first match group captures the characters between the double
backquotes."
  )

(defconst qbk-phrase-block-re
  (concat "\\(?:" qbk-code-block-re "\\|" qbk-escape-re "\\)")
  "A regular expression that matches all phrase markup that can
  contain consecutive newlines with only intervening whitespace."
  )
  
(defconst qbk-intra-block-ws
  (concat
   "\\(?:"
        "[[:blank:]]+\n?[[:blank:]]*"
        "\\|" "\n[[:blank:]]*"
   "\\)"))

(defun qbk-add-class-to-charset (class charset)
  (replace-regexp-in-string "\\(-?\\)\\]$" (concat "[:" class ":]" "\\1]") charset)
  )

(defun qbk-negate-charset (charset)
  (concat "[^" (substring charset 1))
  )

(defconst qbk-no-backslash
  (concat
   "\\(?:" "^" "\\|" "[^\\\n]" "\\)" "\\(?:" "\\\\" "\\\\" "\\)*"))

(defun qbk-simple-re ( delim-char )
  "Return a regular expression that matches quickbook's `Simple
Formatting' with the given DELIM-CHAR.  The first match group
captures the characters between the delimiters.

The regular expression has been extended from what quickbook
allows so simple formatting can cross lines (but not paragraphs).
"
  (let* (
         (delim (regexp-opt-charset (list delim-char)))
         (delim-backslash (regexp-opt-charset (list delim-char ?\\)))
         (non-ws-delim-backslash
          (qbk-negate-charset (qbk-add-class-to-charset "space" delim-backslash)))
         (any-char-re (concat "\\(?:" "." "\\|" "\n" "\\)"))
         (allow-newlines nil)
        )
    (concat
     delim
     "\\("
         "\\S "
         "\\(?:"
                ;; "loop invariant" for this group: the last character
                ;; was not whitespace, and thus we are not at the
                ;; beginning of a line

                ;; Neither whitespace nor a delimiter nor a backslash
                non-ws-delim-backslash

                ;; A backslash-escaped character
                 "\\|" "\\\\" any-char-re
                 
                ;; delimiters are neutered by preceding whitespace,
                ;; so after whitespace we can match any non-space or
                ;; any backslash-escaped character
                "\\|"
                      (if allow-newlines qbk-intra-block-ws "[[:blank:]]+")
                      "\\(?:"
                           "[^\\[:space:]]"
                           "\\|" "\\\\" any-char-re
                      "\\)"
                      
                ;; delimiters are also neutered by trailing
                ;; non-whitespace, non-punctuation.
                "\\|" delim "[^[:space:][:punct:]]"
         "\\)*"
     "\\)"
     delim
     )))

(defconst qbk-simple-delimiters
  "/*_=`"
  "A string containing the characters that quickbook uses for simple formatting"
  )
  
(defconst qbk-all-simple-re
  (concat
   "\\(?:"
   (reduce
    (lambda (re c)
      (let ((c-re (concat (qbk-simple-re c) )))
        (if re (concat re "\\|" c-re) c-re)))
    qbk-simple-delimiters :initial-value nil)
   "\\)"
   )
   "A regular expression that matches any `Simple Formatting' phrase"
   )

(defconst qbk-c-locale-punct
  "!\"#$%&'()*+,-./:;<=>?@[\\]&_^`{|}~"
  )


(defconst qbk-phrase-bracket-punct
  '("/" "'" "*" "_" "^" "-" "~" "#" "@" "$" ":"))

(defconst qbk-phrase-bracket-keywords
  '("link"
    "funcref"
    "classref"
    "memberref"
    "enumref"
    "macroref"
    "conceptref"
    "headerref"
    ))

(defconst qbk-nullary-phrase-bracket-keywords
  '("c++" "python" "br"))

(defconst qbk-phrase-bracket-open-re
  (concat
   "\\[\\(?:"
       (regexp-opt qbk-phrase-bracket-punct)
       "\\|" (regexp-opt qbk-phrase-bracket-keywords) "\\>"
   "\\)"
  ))
  
(defconst qbk-block-bracket-keywords
  '("document"
      "quickbook"
      "version"
      "id"
      "dirname"
      "copyright"
      "purpose"
      "category"
      "authors"
      "license"
      "source-mode"
    "section"
    "xinclude"
    "def"
    "pre"
    "template"
    "blurb"
      "note"
      "tip"
      "important"
      "caution"
      "warning"
    "h1"
    "h2"
    "h3"
    "h4"
    "h5"
    "h6"
    "heading"
    "table"
    "variablelist"
    "include"
  ))


;; tester:
;; (and (looking-at qbk-bracket-phrase-skip) (set-mark (nth 3 (match-data))))

(defconst qbk-nullary-block-bracket-keywords
  '("endsect"
  ))

(let* (
       ;;
       ;; Delimiters are character sequences at which `interesting
       ;; parsing' happens when interpreting a square-bracket-enclosed
       ;; section: everything in qbk-simple-delimiters and also [, ],
       ;; ``, and '''
       (delim-chars   ; A list of all delimiter-opening characters
        (string-to-sequence (concat qbk-simple-delimiters "[]'" ) 'list))

       (simple-delim-charset
        (regexp-opt-charset (string-to-sequence qbk-simple-delimiters 'list)))
       
       (delim-backslash-charset ; delimiter-openers and backslash
        (regexp-opt-charset (cons ?\\ delim-chars)))

       (delim-backslash-nl-charset ; delimiter-openers and backslash
        (regexp-opt-charset (append '(?\\ ?\n) delim-chars)))

       (non-delim-backslash-charset ; everything but delimiter-openers and backslash
        (qbk-negate-charset delim-backslash-charset))

       (non-delim-backslash-nl-charset ; everything but delimiter-openers and backslash
        (qbk-negate-charset delim-backslash-nl-charset))

       ;; Matches the shortest possible sequence of characters that
       ;; definitively does not constitute a delimiter... except for
       ;; ''?  when followed by a delimiter.  Thus when used in
       ;; alternatives you need to handle '\{0,2\} at the beginning of
       ;; every case that begins with a delimiter as well.
       (non-delim-re
        (concat
         "\\(?:"
             "'\\{0,2\\}"
             "\\(?:"
                 non-delim-backslash-charset
                 "\\|"  "\\\\" "."
             "\\)"
         "\\)"
         ))

       ;; Matches all simple markup preceded by up to 2 single quotes
       (all-simple-re
        (concat "\\(?:'\\{0,2\\}" qbk-all-simple-re "\\)"))

       ;; Matches all punctuation other than backslash that isn't in
       ;; delimiters
       (other-punct
        (string-to-sequence
          (replace-regexp-in-string delim-backslash-charset "" qbk-c-locale-punct)
         'list))
       (other-punct-charset (regexp-opt-charset other-punct))

       ;; Matches one whitespace or non-backslash punctuation
       ;; character that isn't in delimiters, or any backslash-escaped
       ;; character
       (other-punct-ws-re
        (concat
         "\\(?:"
             (qbk-add-class-to-charset "space" other-punct-charset)
             "\\|" "\\\\" "."
         "\\)"
         ))

       ;; Matches one space or non-backslash punctuation
       ;; character that isn't in delimiters, or any backslash-escaped
       ;; character other than newline
       (other-punct-space-re
        (concat
         "\\(?:"
             (qbk-add-class-to-charset "blank" other-punct-charset)
             "\\|" "\\\\" "[^\n]"
         "\\)"
         ))

       (non-delim-backslash-ws-charset
        (qbk-add-class-to-charset "space" non-delim-backslash-charset))

       ;; Matches the shortest possible sequence of characters that
       ;; definitively does not constitute a delimiter or
       ;; whitespace... except for ''?  when followed by a delimiter
       ;; opener or whitespace.  Thus when used in alternatives you
       ;; need to handle '\{0,2\} at the beginning of every case that
       ;; begins with a delimiter as well.
       (non-delim-ws-re
        (concat
         "\\(?:"
             "'\\{0,2\\}"
             "\\(?:"
                 non-delim-backslash-ws-charset
                 "\\|"  "\\\\" "[^[:space:]]"
             "\\)"
         "\\)"
         ))
       
       (non-delim-nl-re
        (concat
         "\\(?:"
             "'\\{0,2\\}"
             "\\(?:"
                 non-delim-backslash-nl-charset
                 "\\|"  "\\\\" "[^[:space:]]"
             "\\)"
         "\\)"
         ))

       (single-quote-re
        (concat  "''" qbk-escape-tail-re "?" "\\|" "'"))

       (next-bracket-re
        "[][]")
;;        (concat
;;         "\\(?:" "]" "\\|" qbk-phrase-bracket-open-re "\\)"))
       )

  (;defconst
   setq
   qbk-bracket-skip
    (concat
     "\\("
         "\\(?:"
             non-delim-re "+"     ;; eat non-delimiters
             "\\|"
             ;; This clause only active if we find a delimiter
             all-simple-re "+" ;; `Simple Formatting' phrases must be followed 
             "\\(?:"               ;; by whitespace or punctuation
                 other-punct-ws-re
                 "\\|" qbk-code-block-re
                 ;; These include fallbacks
                 "\\|" single-quote-re
                 "\\|" simple-delim-charset
             "\\)"
             "\\|" single-quote-re
             "\\|" simple-delim-charset
         "\\)*"
         all-simple-re "?"
     "\\)"
     next-bracket-re
     )
    )
    
  (;defconst
   setq
   qbk-bracket-phrase-skip
    (concat
     "\\("
         ;; "loop invariants:"
         ;; - the previous character is not a newline.
         ;; - we're not in `Simple Formatting' or an `Escape'
         "\\(?:"
             qbk-intra-block-ws "?"
             "\\(?:"
                 non-delim-ws-re "+" ;; eat non-delimiters
                 "\\|"
                 ;; This clause only active if we find a delimiter
                 all-simple-re "+"     ;; `Simple Formatting' phrases must be followed 
                 "\\(?:"               ;; by whitespace or punctuation
                     other-punct-space-re
                     "\\|" qbk-code-block-re
                     ;; These include fallbacks
                     "\\|" single-quote-re
                     "\\|" simple-delim-charset
                 "\\)"
                 "\\|" single-quote-re
                 "\\|" simple-delim-charset
             "\\)"
         "\\)*"
         qbk-intra-block-ws "?"
         all-simple-re "?"
     "\\)"
     next-bracket-re
     )
    )
  )

(defun qbk-looking-at (regexp bound)
  (and
   (save-excursion
     (re-search-forward regexp bound t))
   (= (point) (car (match-data)))))

(defun qbk-bracket-matcher ( opener-re phrase bound )
  "A font-lock matcher for syntax of the form

     [OPENER-RE ... ]

   that matches whatever is in ..."
  (let* ((skip (if phrase qbk-bracket-phrase-skip qbk-bracket-skip))
         (depth 1)
         (start)
         (finish)
         (full-opener-re (concat "\\(" qbk-no-backslash "\\)" "\\[" opener-re skip ))
         )


    (message "bracket matching %s at %s" opener-re (point))
    (if

     ;; Try to find the whole pattern
     (save-excursion

       (while ;; Still not found and can find full opening pattern
           (and (> depth 0) (re-search-forward full-opener-re bound t))

         (progn
            (setq start (match-end 1))
            (setq depth 1)
            
            ;; process next bracket and skip until depth = 0
            (while
              (progn
                (setq finish (match-end 0))
                (goto-char finish)
                (setq depth (case (char-before)
                              (?[ (+ depth 1))
                                (?] (- depth 1))
                              (otherwise (error "expected [ or ]"))
                              ))
                (and
                 (> depth 0)
                 (or
                  ;; Prefer parsing known phrase brackets
                  (qbk-looking-at skip bound)
                  (qbk-looking-at qbk-bracket-phrase-skip bound)
                  )
                 )
                )
              )
            
            ;; In case we need to search again, start at the opening
            ;; brace (which matches the "non-backslash prefix"
            ;; requirement for the next instance of this pattern.
            (goto-char start)

            ;; except that it will match at the same position if the
            ;; brace occurs at the the beginning of a line
            (if (bolp) (forward-char))
            )
         ) ;; while
       
         (= depth 0) ; found?
       )

        ;; then
        (progn
          (goto-char (- finish 1))
          (set-match-data
           (list start finish))
          t)
      ); if
    ))

(defun qbk-simple-matcher (delim-char bound)
  (and
   (save-excursion
     (re-search-forward
      (concat
       qbk-no-backslash
       "\\(" (qbk-simple-re delim-char) "\\)"
       "\\(?:[[:space:][:punct:]]\\|$\\)"
       )
      bound t)
     )
   (let ((p (- (match-end 1) 1)))
     (and (> p (point))
          (or (goto-char p) t)))
   ))
  
(defun qbk-font-lock-keywords-function ()
  "Returns keywords to highlight in qbk mode according to current settings."
  ;; The reST-links in the comments below all relate to sections in
  ;; http://docutils.sourceforge.net/spec/qbk/quickbook.html
  (let* ( ;; define some abbreviations
         (block)
	 )
    (list
     (list (lambda (bound) (qbk-bracket-matcher "h1\\>" nil bound)) 0 qbk-level-1-face)
     (list (lambda (bound) (qbk-bracket-matcher "h2\\>" nil bound)) 0 qbk-level-2-face)
     (list (lambda (bound) (qbk-bracket-matcher "h3\\>" nil bound)) 0 qbk-level-3-face)
     (list (lambda (bound) (qbk-bracket-matcher "h4\\>" nil bound)) 0 qbk-level-4-face)
     (list (lambda (bound) (qbk-bracket-matcher "h5\\>" nil bound)) 0 qbk-level-5-face)
     (list (lambda (bound) (qbk-bracket-matcher "h6\\>" nil bound)) 0 qbk-level-6-face)
     
     (list (lambda (bound) (qbk-bracket-matcher "'" t bound)) 0 qbk-emphasis1-face 'prepend)
     (list (lambda (bound) (qbk-simple-matcher ?/ bound)) 1 qbk-emphasis1-face 'prepend)
     
     (list (lambda (bound) (qbk-bracket-matcher "\\*" t bound)) 0 qbk-emphasis2-face 'prepend)
     (list (lambda (bound) (qbk-simple-matcher ?* bound)) 1 qbk-emphasis2-face 'prepend)
     
     
     (list (lambda (bound) (qbk-bracket-matcher "\\^" t bound)) 0 qbk-literal-face t 'prepend)
     (list (lambda (bound) (qbk-simple-matcher ?= bound)) 1 qbk-literal-face 'prepend)
     
     (list (lambda (bound) (qbk-bracket-matcher "_" t bound)) 0 qbk-underline-face 'prepend)
     (list (lambda (bound) (qbk-simple-matcher ?_ bound)) 1 qbk-underline-face 'prepend)
     
     (list (lambda (bound) (qbk-bracket-matcher "-" t bound)) 0 qbk-strikethrough-face 'prepend)
     
     (list (lambda (bound) (qbk-bracket-matcher "~" t bound)) 0 qbk-replaceable-face 'prepend)
     
     (list (lambda (bound) (qbk-bracket-matcher "/" t bound)) 0 qbk-comment-face t)
      (list (concat qbk-no-backslash "\\(" qbk-escape-re "\\)")
            1 qbk-literal-face t)
     )
    )
  )


  (defun highlight-looking-at (re)
    (if (not (looking-at re)) nil
      (goto-char (nth 3 (match-data)))
      (set-mark (nth 2 (match-data)))
      (exchange-point-and-mark t)
	(setq mark-active t)
      )
    )
  

