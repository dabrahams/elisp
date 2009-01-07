(autoload 'mc-install-write-mode "mailcrypt" nil t)
(autoload 'mc-install-read-mode "mailcrypt" nil t)

;; Integrate with other packages.
;;
;; Hooks can be added before the corresponding packages are loaded.
;; This allows us to keep all mailcrypt hooking in one place without
;; forcing these packages to load.
(add-hook 'gnus-summary-mode-hook 'mc-install-read-mode) ; gnus
(add-hook 'message-mode-hook 'mc-install-write-mode)     ; message-mail
(add-hook 'news-reply-mode-hook 'mc-install-write-mode)  ; supercite
