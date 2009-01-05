;;
;; Where I store my own customizations
;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote (("\\`/[^/]*:\\([^/]*/\\)*\\([^/]*\\)\\'" "/tmp/\\2" t) ("\\`\\(?:[^/]*/\\)*\\([^/]*\\)\\'" "~/.emacs.d/auto-saves/\\1" t))) nil nil "
Added a 2nd regexp to try to ensure that the auto-save files are
always collected in a common directory")
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(blink-cursor-mode nil nil nil "
Blinking cursor just annoys me")
 '(browse-url-browser-function (quote w3m-browse-url))
 '(canlock-password "963afd5a40a33c7f59217100af5a7c1648af74a1")
 '(default-frame-alist (quote ((menu-bar-lines . 1) (font-backend . "xft") (font . "Bitstream Vera Sans Mono-10.5"))) nil nil "
Despite what the customize interface says, menu-bar-lines and tool-bar-lines are
set to 1 as part of the default value.  However, customizing tool-bar-mode to nil
sets tool-bar-lines to zero here.

According to <http://article.gmane.org/gmane.emacs.devel/99324>, we need to explicitly set the font-backend to XFT or we won't get antialiasing.  

Had to evaluate (x-select-font) to find out the name of the font that emacs would recognize.")
 '(delete-selection-mode t nil nil "
Creates normal editor behavior: select a region and begin
typing, the region is replaced")
 '(diff-jump-to-old-file t)
 '(dired-listing-switches "-alh" nil nil "
Added -h so I can read file sizes")
 '(ediff-merge-filename-prefix "")
 '(ediff-skip-merge-regions-that-differ-from-default nil)
 '(erc-modules (quote (autoaway autojoin button completion fill irccontrols list log match menu move-to-prompt netsplit networks noncommands readonly ring smiley sound stamp track)))
 '(gdb-max-frames 100 nil nil "
Increased the number of stack frames displayed from 40")
 '(global-auto-revert-mode t nil nil "
We want our file buffers to stay up-to-date with changes on disk")
 '(gnus-buttonized-mime-types (quote ("multipart/signed" "multipart/alternative" "application/msword")))
 '(gnus-treat-fill-long-lines (quote first) nil nil "
Some people don't embed linebreaks in their paragraphs; this will force-add them.")
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((menu-bar-lines . 1) (tool-bar-lines . 0) (font-backend . "xft") (font . "Bitstream Vera Sans Mono-10.5"))))
 '(message-cite-prefix-regexp "\\([ 	]*[_.[:word:]]+>+\\|[ 	]*[]>|]\\)+" nil nil "
Removed \"}\" from the allowable characters because I often type that when writing replies.")
 '(mm-attachment-override-types (quote ("text/x-vcard" "application/pkcs7-mime" "application/x-pkcs7-mime" "application/pkcs7-signature" "application/x-pkcs7-signature" "image/*")) nil nil "
Added image/* to display attached images inline")
 '(mm-discouraged-alternatives (quote ("text/html" "text/richtext" "image/.*")) nil nil "
The documentation for this variable says it all")
 '(muse-project-alist (quote (("WikiPlanner" ("~/plans" :default "index" :major-mode planner-mode :visit-link planner-visit-link)))))
 '(org-agenda-files (quote ("~/organizer.org")))
 '(ps-font-family (quote Helvetica))
 '(ps-font-info-database (quote ((Courier (fonts (normal . "Courier") (bold . "Courier-Bold") (italic . "Courier-Oblique") (bold-italic . "Courier-BoldOblique")) (size . 10.0) (line-height . 10.55) (space-width . 6.0) (avg-char-width . 6.0)) (Helvetica (fonts (normal . "Helvetica") (bold . "Helvetica-Bold") (italic . "Helvetica-Oblique") (bold-italic . "Helvetica-BoldOblique")) (size . 10.0) (line-height . 11.56) (space-width . 2.78) (avg-char-width . 5.09243)) (Times (fonts (normal . "Times-Roman") (bold . "Times-Bold") (italic . "Times-Italic") (bold-italic . "Times-BoldItalic")) (size . 10.0) (line-height . 11.0) (space-width . 2.5) (avg-char-width . 4.71432)) (Palatino (fonts (normal . "Palatino-Roman") (bold . "Palatino-Bold") (italic . "Palatino-Italic") (bold-italic . "Palatino-BoldItalic")) (size . 10.0) (line-height . 12.1) (space-width . 2.5) (avg-char-width . 5.08676)) (Helvetica-Narrow (fonts (normal . "Helvetica-Narrow") (bold . "Helvetica-Narrow-Bold") (italic . "Helvetica-Narrow-Oblique") (bold-italic . "Helvetica-Narrow-BoldOblique")) (size . 10.0) (line-height . 11.56) (space-width . 2.2796) (avg-char-width . 4.17579)) (NewCenturySchlbk (fonts (normal . "NewCenturySchlbk-Roman") (bold . "NewCenturySchlbk-Bold") (italic . "NewCenturySchlbk-Italic") (bold-italic . "NewCenturySchlbk-BoldItalic")) (size . 10.0) (line-height . 12.15) (space-width . 2.78) (avg-char-width . 5.31162)) (AvantGarde-Book (fonts (normal . "AvantGarde-Book") (italic . "AvantGarde-BookOblique")) (size . 10.0) (line-height . 11.77) (space-width . 2.77) (avg-char-width . 5.45189)) (AvantGarde-Demi (fonts (normal . "AvantGarde-Demi") (italic . "AvantGarde-DemiOblique")) (size . 10.0) (line-height . 12.72) (space-width . 2.8) (avg-char-width . 5.51351)) (Bookman-Demi (fonts (normal . "Bookman-Demi") (italic . "Bookman-DemiItalic")) (size . 10.0) (line-height . 11.77) (space-width . 3.4) (avg-char-width . 6.05946)) (Bookman-Light (fonts (normal . "Bookman-Light") (italic . "Bookman-LightItalic")) (size . 10.0) (line-height . 11.79) (space-width . 3.2) (avg-char-width . 5.67027)) (Symbol (fonts (normal . "Symbol")) (size . 10.0) (line-height . 13.03) (space-width . 2.5) (avg-char-width . 3.24324)) (Zapf-Dingbats (fonts (normal . "Zapf-Dingbats")) (size . 10.0) (line-height . 9.63) (space-width . 2.78) (avg-char-width . 2.78)) (ZapfChancery-MediumItalic (fonts (normal . "ZapfChancery-MediumItalic")) (size . 10.0) (line-height . 11.45) (space-width . 2.2) (avg-char-width . 4.10811)) (Zapf-Chancery-MediumItalic (fonts (normal . "ZapfChancery-MediumItalic")) (size . 10.0) (line-height . 11.45) (space-width . 2.2) (avg-char-width . 4.10811)))))
 '(server-mode nil nil nil "
Always run a server so we can open files in existing emacs frames.")
 '(show-paren-mode t)
 '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
 '(tool-bar-mode nil nil nil "
Tool bars take up valuable screen real-estate for icons whose meaning I forget")
 '(tramp-backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(tramp-encoding-shell "bash")
 '(truncate-partial-width-windows nil)
 '(w3m-confirm-leaving-secure-page t nil nil "
I never like being nannied by regular browsers either.")
 '(w3m-default-display-inline-images t)
 '(w3m-display-ins-del nil)
 '(w3m-icon-directory "~/elisp/package.d/w3m-el/icons")
 '(w3m-use-cookies t)
 '(x-select-enable-clipboard t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-refine-change ((default nil) (nil (:background "#FFFFC0"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:background "Beige" :foreground "DarkGreen" :slant italic)))))
