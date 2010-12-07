;; This file contains autoloads that perhaps ought to have been
;; embedded in packages I'm using, but weren't.

(autoload 'doc-mode "doc-mode")
(add-to-list 'auto-mode-alist '("\\.asciidoc\\'". doc-mode))

(autoload 'magit-status "magit"
  "magit package supplies no doc." t)

(autoload 'cmake-mode "cmake-mode"
  "Major mode for editing CMake listfiles." t)

(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'jam-mode "jam-mode"
  "no doc provided." t)

(setq auto-mode-alist
	  (append
	   '(("`Jamfile\\(\\.v2\\)'" . jam-mode))
	   '(("`Jamroot'" . jam-mode))
	   '(("\\.jam\\'" . jam-mode))
	   auto-mode-alist))

(autoload 'markdown-mode "markdown-mode"
        "Major mode for editing Markdown files" t)

(autoload 'unicode-character-insert "my-xmlunicode"
"Insert a Unicode character by character name. If a prefix is given, the character will be inserted regardless of whether or not it has a displayable glyph; otherwise, a numeric character reference is inserted if the codepoint is not in the unicode-glyph-list. If argname is given, it is used for the prompt. If argname uniquely identifies a character, that character is inserted without the prompt." t)

(autoload 'iso8879-character-insert "my-xmlunicode"
"Insert a Unicode character by ISO 8879 entity name. If a prefix is given, the character will be inserted regardless of whether or not it has a displayable glyph; otherwise, a numeric character reference is inserted if the codepoint is not in the unicode-glyph-list. If argname is given, it is used for the prompt. If argname uniquely identifies a character, that character is inserted without the prompt." t)

(autoload 'unicode-smart-double-quote "my-xmlunicode"
  "Insert a left or right double quote as appropriate. Left quotes are inserted after a space, newline, or start tag. Right quotes are inserted after any other character, except if the preceding character is a quote, in which case we cycle through the three quote styles." t)

(autoload 'unicode-smart-single-quote "my-xmlunicode"
  "Insert a left or right single quote, or an apostrophe, as appropriate. Left quotes are inserted after a space, newline, or start tag. An apostrophe is inserted after any other character, except if the preceding character is a quote or apostrophe, in which case we cycle through the styles." t)

(autoload 'unicode-character-menu-insert "my-xmlunicode"
  "Popup a menu for inserting unicode characters." t)

(autoload 'unicode-character-shortcut-insert "my-xmlunicode" "Read
a (two-character) keyboard shortcut and insert the corresponding
character." t)

(autoload 'unicode-smart-period "my-xmlunicode" "Insert an hellipsis for three dots." t)

;; This is probably not needed, but I forgot how to get 3rd-party
;; packages to generate autoloads for me.
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
(autoload 'wl-user-agent-compose "wl-draft" nil t)

(autoload 'weblogger "weblogger-fetch-entries" "Sync the entry ring with what is on the weblog server." t)
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files." t)
