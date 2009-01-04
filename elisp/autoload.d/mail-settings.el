;; Mail settings
(defun my-message-insert-citation-line ()
  "Insert a simple citation line."
  (when message-reply-headers
    (insert "\non " (format-time-string "%a %b %d %Y" (date-to-time (mail-header-date message-reply-headers))) ", "
    (replace-regexp-in-string "@" "-AT-" (mail-header-from message-reply-headers)) " wrote:\n\n")))

(add-hook 'message-mode-hook
          '(lambda () (auto-fill-mode t)))

(when
    (ignore-errors (require 'mailcrypt))
  (mc-setversion "gpg")
  (autoload 'mc-install-write-mode "mailcrypt" nil t)
  (autoload 'mc-install-read-mode "mailcrypt" nil t)
  (add-hook 'gnus-summary-mode-hook 'mc-install-read-mode)
  (add-hook 'message-mode-hook 'mc-install-write-mode)
  (add-hook 'news-reply-mode-hook 'mc-install-write-mode))

(setq-default
 user-full-name "David Abrahams"
 user-mail-address "dave@boostpro.com"
 mail-user-agent 'message-user-agent


 ;; For use with a local Exim MTA
 send-mail-function 'sendmail-send-it
 sendmail-program "exim"

 message-send-mail-function 'smtpmail-send-it
      
 message-subject-re-regexp "^[ 	]*\\(\\([Rr][Ee]\\|[Aa][Ww]\\)\\(\\[[0-9]*\\]\\)*:[ 	]*\\)*[ 	]*"
 message-syntax-checks '((sender . disabled) (long-lines . disabled))
 message-subject-trailing-was-query t ;; always strip the trailing old subject in (was: ...) subjects
 message-default-headers "Bcc: dave@boostpro.com"
 message-dont-reply-to-names "\\(dave@boost\\(-consulting\\|pro\\)\\.com\\)\\|\\(david\\.abrahams@rcn\\.com\\)\\|\\(Undisclosed-recipients[:;]*\\)"
     
 message-citation-line-function (quote my-message-insert-citation-line)
 message-forward-ignored-headers "^Content-Transfer-Encoding:\\|^X-\\|^Received:\\|^User-Agent:\\|^References:"
 mm-inline-text-html-with-images t

 smtpmail-default-smtp-server "www.boostpro.com"
 smtpmail-local-domain "boostpro.com"
 ;; (setq smtpmail-debug-info t) to make a trace of all SMTP transactions

 ;; have gnutls (ubuntu package gnutls-bin) installed or this won't work.
 ;; starttls doesn't do it!
 smtpmail-smtp-service 587
      
 smtpmail-starttls-credentials
 '(
   ("www.boostpro.com" 587 "" "")
   )
)