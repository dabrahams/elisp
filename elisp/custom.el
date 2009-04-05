;;
;; Where I store my own customizations
;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-coding-alist (quote (("\\.\\(arc\\|egg\\|zip\\|lzh\\|lha\\|zoo\\|[jew]ar\\|xpi\\|rar\\|ARC\\|ZIP\\|LZH\\|LHA\\|ZOO\\|[JEW]AR\\|XPI\\|RAR\\)\\'" . no-conversion-multibyte) ("\\.\\(exe\\|EXE\\)\\'" . no-conversion) ("\\.\\(sx[dmicw]\\|odt\\|tar\\|tgz\\)\\'" . no-conversion) ("\\.\\(gz\\|Z\\|bz\\|bz2\\|gpg\\)\\'" . no-conversion) ("\\.\\(jpe?g\\|png\\|gif\\|tiff?\\|p[bpgn]m\\)\\'" . no-conversion) ("\\.pdf\\'" . no-conversion) ("/#[^/]+#\\'" . emacs-mule))) nil nil "
Added Python .egg file handling")
 '(auto-save-file-name-transforms (quote (("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" "/tmp/\\2" t) ("\\`\\(?:[^/]*/\\)*\\([^/]*\\)\\'" "~/.emacs.d/auto-saves/\\1" t))) nil nil "
Added a 2nd regexp to try to ensure that the auto-save files are
always collected in a common directory")
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(blink-cursor-mode nil nil nil "
Blinking cursor just annoys me")
 '(browse-url-browser-function (quote w3m-browse-url))
 '(canlock-password "963afd5a40a33c7f59217100af5a7c1648af74a1")
 '(cursor-type (quote box))
 '(default-frame-alist (quote ((menu-bar-lines . 1) (font-backend . "xft") (font . "Bitstream Vera Sans Mono-10.5"))) nil nil "
This is really just a way of hanging onto and documenting my
settings for for default-frame-alist, which currently aren't
needed since I have an .Xdefaults file containing:

  Emacs.FontBackend: xft
  Emacs.font: Bitstream Vera Sans Mono-10.5
  Emacs.toolBar: 0
  Emacs.menuBar: 1

Doing it in .Xdefaults prevents the initial window from flashing
and resizing.

Note that, on ubuntu at least, one must do 

  xrdb -merge ~/.Xdefaults

to get the changes to take effect

Despite what the customize interface says, menu-bar-lines and 
tool-bar-lines are set to 1 as part of the default value.  
However, customizing tool-bar-mode to nil sets tool-bar-lines
to zero here.

According to <http://article.gmane.org/gmane.emacs.devel/99324>, 
we need to explicitly set the font-backend to XFT or we won't 
get antialiasing.  

Had to evaluate (x-select-font) to find out the name of the
font that emacs would recognize.
")
 '(delete-selection-mode t nil nil "
Creates normal editor behavior: select a region and begin
typing, the region is replaced")
 '(diff-default-read-only t nil nil "
If you don't do this, all the nice navigation stuff is disabled by default.  Who wants to edit diffs by hand, anyway?")
 '(diff-jump-to-old-file t)
 '(dired-listing-switches "-alh" nil nil "
Added -h so I can read file sizes")
 '(ediff-custom-diff-options "-u" nil nil "
Show me unified diffs by default")
 '(ediff-highlight-all-diffs nil nil nil "
only highlight the selected diff (keeps down gray cruft onscreen)")
 '(ediff-keep-variants t nil nil "
Any unchanged buffers in the ediff are removed when the session ends. 
`C-u q' to override when quitting.")
 '(ediff-merge-filename-prefix "")
 '(ediff-skip-merge-regions-that-differ-from-default nil)
 '(ediff-split-window-function (quote split-window-horizontally) nil nil "
Show diffs side-by-side")
 '(ediff-window-setup-function (quote ediff-setup-windows-plain) nil nil "
Run Ediff all in one frame.  The default when there's a window manager is for
emacs to pop up a separate frame for the `*Ediff Control Panel*' buffer")
 '(erc-modules (quote (autoaway autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring smiley sound stamp track)))
 '(explicit-bash-args (quote ("--noediting" "-i" "-l")) nil nil "
added -l so it would take things out of my .bash_profile, like (on boostpro.com) the prompt pattern.  Otherwise I get this abomination: ///bd5882fff11dd5c2900e1ce95b895e66")
 '(explicit-shell-file-name "bash" nil nil "
Giving an explicit path like /bin/bash (the default from my Linux boxen) fails on FreeBSD where the file doesn't live there.")
 '(gdb-max-frames 100 nil nil "
Increased the number of stack frames displayed from 40")
 '(global-auto-revert-mode t nil nil "
We want our file buffers to stay up-to-date with changes on disk")
 '(gnus-buttonized-mime-types (quote ("multipart/signed" "multipart/alternative" "application/msword")))
 '(gnus-treat-fill-long-lines (quote first) nil nil "
Some people don't embed linebreaks in their paragraphs; this will force-add them.")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(mac-command-modifier (quote meta))
 '(mac-option-modifier (quote super))
 '(mail-user-agent (quote gnus-user-agent) nil nil "
Gnus Message with full Gnus features")
 '(message-citation-line-function (quote my-message-insert-citation-line) nil nil "
Make sure peoples' email addresses are (trivially) obscured")
 '(message-cite-prefix-regexp "\\([ 	]*[_.[:word:]]+>+\\|[ 	]*[]>|]\\)+" nil nil "
Removed \"}\" from the allowable characters because I often type that when writing replies.")
 '(message-default-headers "Bcc: dave@boostpro.com
" nil nil "
Always Bcc: myself")
 '(message-dont-reply-to-names (quote ("dave@boost-consulting\\.com" "dave@boostpro\\.com" "david\\.abrahams@rcn\\.com" "boost\\.consulting@gmail\\.com" "dave\\.boostpro@gmail\\.com" "Undisclosed-recipients[:;]*")))
 '(message-forward-ignored-headers (quote ("^Content-Transfer-Encoding:" "^X-Gnus" "^X-" "^Received:" "^User-Agent:" "^References:")))
 '(message-mode-hook (quote ((lambda nil (auto-fill-mode t)))) nil nil "
Automatically wrap text during email composition")
 '(message-send-mail-function (quote message-smtpmail-send-it) nil nil "
If we ever go back to using a local exim MTA, we'll set this back to message-send-mail-with-sendmail")
 '(message-subject-re-regexp "^[ 	]*\\(\\([Rr][Ee]\\|[Aa][Ww]\\)\\(\\[[0-9]*\\]\\)*:[ 	]*\\)*[ 	]*" nil nil "
Handle Germans' Aw: version of Re:")
 '(message-subject-trailing-was-query t nil nil "
always strip the trailing old subject in (was: ...) subjects")
 '(message-syntax-checks (quote ((sender . disabled) (long-lines . disabled))) nil nil "
Don't complain about long lines, please")
 '(mm-attachment-override-types (quote ("text/x-vcard" "application/pkcs7-mime" "application/x-pkcs7-mime" "application/pkcs7-signature" "application/x-pkcs7-signature" "image/*")) nil nil "
Added image/* to display attached images inline")
 '(mm-discouraged-alternatives (quote ("text/html" "text/richtext" "image/.*")) nil nil "
The documentation for this variable says it all")
 '(mm-inline-text-html-with-images t)
 '(muse-project-alist (quote (("WikiPlanner" ("~/plans" :default "index" :major-mode planner-mode :visit-link planner-visit-link)))))
 '(ns-alternate-modifier (quote super) t)
 '(ns-command-modifier (quote meta) t)
 '(org-agenda-custom-commands (quote (("d" todo #("DELEGATED" 0 9 (face org-warning)) nil) ("c" todo #("DONE|DEFERRED|CANCELLED" 0 23 (face org-warning)) nil) ("w" todo #("WAITING" 0 7 (face org-warning)) nil) ("W" agenda "" ((org-agenda-ndays 21))) ("A" agenda "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]"))) (org-agenda-ndays 1) (org-agenda-overriding-header "Today's Priority #A tasks: "))) ("u" "Unscheduled TODO entries" alltodo "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote scheduled) (quote deadline) (quote regexp) "<[^>
]+>"))))))))
 '(org-agenda-files (quote ("~/todo.org")) nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(org-agenda-skip-deadline-if-done t nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(org-agenda-skip-scheduled-if-done t nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(org-agenda-start-on-weekday nil nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(org-default-notes-file "~/notes.org" nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(org-fast-tag-selection-single-key (quote expert) nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(org-mac-mail-account "BoostPro")
 '(org-modules (quote (org-bbdb org-bibtex org-gnus org-info org-jsinfo org-irc org-mac-message org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(org-remember-templates (quote (("" 116 "* TODO %?
  %u" "~/todo.org" "Tasks" nil) ("" 110 "* %u %?" "~/notes.org" "Notes" nil))) nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(org-reverse-note-order t nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html")
 '(ps-font-family (quote Helvetica))
 '(ps-font-info-database (quote ((Courier (fonts (normal . "Courier") (bold . "Courier-Bold") (italic . "Courier-Oblique") (bold-italic . "Courier-BoldOblique")) (size . 10.0) (line-height . 10.55) (space-width . 6.0) (avg-char-width . 6.0)) (Helvetica (fonts (normal . "Helvetica") (bold . "Helvetica-Bold") (italic . "Helvetica-Oblique") (bold-italic . "Helvetica-BoldOblique")) (size . 10.0) (line-height . 11.56) (space-width . 2.78) (avg-char-width . 5.09243)) (Times (fonts (normal . "Times-Roman") (bold . "Times-Bold") (italic . "Times-Italic") (bold-italic . "Times-BoldItalic")) (size . 10.0) (line-height . 11.0) (space-width . 2.5) (avg-char-width . 4.71432)) (Palatino (fonts (normal . "Palatino-Roman") (bold . "Palatino-Bold") (italic . "Palatino-Italic") (bold-italic . "Palatino-BoldItalic")) (size . 10.0) (line-height . 12.1) (space-width . 2.5) (avg-char-width . 5.08676)) (Helvetica-Narrow (fonts (normal . "Helvetica-Narrow") (bold . "Helvetica-Narrow-Bold") (italic . "Helvetica-Narrow-Oblique") (bold-italic . "Helvetica-Narrow-BoldOblique")) (size . 10.0) (line-height . 11.56) (space-width . 2.2796) (avg-char-width . 4.17579)) (NewCenturySchlbk (fonts (normal . "NewCenturySchlbk-Roman") (bold . "NewCenturySchlbk-Bold") (italic . "NewCenturySchlbk-Italic") (bold-italic . "NewCenturySchlbk-BoldItalic")) (size . 10.0) (line-height . 12.15) (space-width . 2.78) (avg-char-width . 5.31162)) (AvantGarde-Book (fonts (normal . "AvantGarde-Book") (italic . "AvantGarde-BookOblique")) (size . 10.0) (line-height . 11.77) (space-width . 2.77) (avg-char-width . 5.45189)) (AvantGarde-Demi (fonts (normal . "AvantGarde-Demi") (italic . "AvantGarde-DemiOblique")) (size . 10.0) (line-height . 12.72) (space-width . 2.8) (avg-char-width . 5.51351)) (Bookman-Demi (fonts (normal . "Bookman-Demi") (italic . "Bookman-DemiItalic")) (size . 10.0) (line-height . 11.77) (space-width . 3.4) (avg-char-width . 6.05946)) (Bookman-Light (fonts (normal . "Bookman-Light") (italic . "Bookman-LightItalic")) (size . 10.0) (line-height . 11.79) (space-width . 3.2) (avg-char-width . 5.67027)) (Symbol (fonts (normal . "Symbol")) (size . 10.0) (line-height . 13.03) (space-width . 2.5) (avg-char-width . 3.24324)) (Zapf-Dingbats (fonts (normal . "Zapf-Dingbats")) (size . 10.0) (line-height . 9.63) (space-width . 2.78) (avg-char-width . 2.78)) (ZapfChancery-MediumItalic (fonts (normal . "ZapfChancery-MediumItalic")) (size . 10.0) (line-height . 11.45) (space-width . 2.2) (avg-char-width . 4.10811)) (Zapf-Chancery-MediumItalic (fonts (normal . "ZapfChancery-MediumItalic")) (size . 10.0) (line-height . 11.45) (space-width . 2.2) (avg-char-width . 4.10811)))))
 '(remember-annotation-functions (quote (org-remember-annotation)) nil nil "
As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html.  Note: buffer-file-name was checked in the default.")
 '(remember-handler-functions (quote (org-remember-handler)) nil nil "As prescribed by http://www.newartisans.com/2007/08/using-org-mode-as-a-day-planner.html.  Note: remember-append-to-file is checked in the default.")
 '(rmail-dont-reply-to-names "dave@\\(boost-consulting\\|boostpro\\)\\.com\\|dave\\.abrahams@rcn\\.com\\|boost\\.consulting@gmail\\.com\\|dave\\.boostpro@gmail\\.com\\|Undisclosed-recipients[:;]*")
 '(safe-local-variable-values (quote ((folded-file . t))))
 '(server-mode t nil nil "
Always run a server so we can open files in existing emacs frames.")
 '(show-paren-mode t)
 '(smtpmail-default-smtp-server "www.boostpro.com")
 '(smtpmail-local-domain "boostpro.com")
 '(smtpmail-smtp-service 587)
 '(smtpmail-starttls-credentials (quote (("www.boostpro.com" 587 "" ""))))
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(tool-bar-mode nil nil nil "
Tool bars take up valuable screen real-estate for icons whose meaning I forget")
 '(tramp-backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(tramp-default-proxies-alist (quote (("\\`localhost\\'" "\\`root\\'" "/sudo::") ("\\`127.0.0.1\\'" "\\`root\\'" "/sudo::") ("\\`\\'" "\\`root\\'" "/sudo::") ("\\`.+\\'" "\\`root\\'" "/ssh:%h:"))))
 '(tramp-encoding-shell "bash" nil nil "
Needed in order to enable tilde expansion, etc., in remote shells")
 '(tramp-remote-path (quote (tramp-default-remote-path "/usr/sbin" "/usr/local/sbin" "/usr/local/bin" "/sbin" "/local/bin" "/local/freeware/bin" "/local/gnu/bin" "/usr/freeware/bin" "/usr/pkg/bin" "/usr/contrib/bin")))
 '(truncate-partial-width-windows nil)
 '(user-mail-address "dave@boostpro.com")
 '(vc-diff-switches "-du")
 '(w3m-confirm-leaving-secure-page t nil nil "
I never like being nannied by regular browsers either.")
 '(w3m-default-display-inline-images t)
 '(w3m-display-ins-del nil)
 '(w3m-icon-directory "~/elisp/package.d/w3m-el/icons")
 '(w3m-use-cookies t)
 '(warning-suppress-types (quote ((\(undo\ discard-info\)))) nil nil "
Without this, emacs pops up annoying warnings in, e.g., *shell* buffers
where I don't expect it to be keeping undo history anyway")
 '(x-select-enable-clipboard t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cursor ((default (:background "brown")) (nil nil)))
 '(diff-refine-change ((default nil) (nil (:background "#FFFFC0"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:background "Beige" :foreground "DarkGreen" :slant italic)))))
