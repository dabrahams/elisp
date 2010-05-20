;; Fill messages, thanks to Ron Isaacson <Ron.Isaacson-AT-morganstanley.com>
;;
(require 'mime-conf)
(require 'wl-summary)

(require 'filladapt)

(defun wl-summary-fill-message (all)
  (interactive "P")
  (if (and wl-message-buffer (get-buffer-window wl-message-buffer))
      (progn
        (wl-summary-toggle-disp-msg 'on)
        (save-excursion
          (set-buffer wl-message-buffer)
          (goto-char (point-min))
          (re-search-forward "^$")
          (while (or (looking-at "^\\[[1-9]") (looking-at "^$"))
            (forward-line 1))
          (let* ((buffer-read-only nil)
                 (find (lambda (regexp)
                         (save-excursion
                           (if (re-search-forward regexp nil t)
                               (match-beginning 0)
                             (point-max)))))
                 (start (point))
                 (end (if all
                          (point-max)
                        (min (funcall find "^[^>\n]* wrote:[ \n]+")
                             (funcall find "^>>>>>")
                             (funcall find "^ *>.*\n *>")
                             (funcall find "^-----Original Message-----")))))
            (save-restriction
              (narrow-to-region start end)
              (filladapt-mode 1)
              (fill-region (point-min) (point-max)))))
        (message "Message re-filled"))
    (message "No message to re-fill")))

(define-key wl-summary-mode-map "\M-q" 'wl-summary-fill-message)

;;
;; Send HTML email, From David Maus David Maus <dmaus-AT-ictsoc.de>
;; (http://article.gmane.org/gmane.mail.wanderlust.general.japanese/7460)
;;

(defun dmj/wl-send-html-message ()
  "Send message as html message.
  Convert body of message to html using
  `org-export-region-as-html'."
  (require 'org)
  (save-excursion
    (let (beg end html text)
      (goto-char (point-min))
      (re-search-forward "^--text follows this line--$")
      ;; move to beginning of next line
      (beginning-of-line 2)
      (setq beg (point))
      (if (not (re-search-forward "^--\\[\\[" nil t))
          (setq end (point-max))
        ;; line up
        (end-of-line 0)
        (setq end (point)))
      ;; grab body
      (setq text (buffer-substring-no-properties beg end))
      ;; convert to html
      (with-temp-buffer
        (org-mode)
        (insert text)
        ;; handle signature
        (when (re-search-backward "^-- \n" nil t)
          ;; preserve link breaks in signature
          (insert "\n#+BEGIN_VERSE\n")
          (goto-char (point-max))
          (insert "\n#+END_VERSE\n")
          ;; grab html
          (setq html (org-export-region-as-html
                      (point-min) (point-max) t 'string))))
      (delete-region beg end)
      (insert
       (concat
	"--" "<<alternative>>-{\n"
	"--" "[[text/plain]]\n" text
        "--" "[[text/html]]\n"  html
	"--" "}-<<alternative>>\n")))))

(defun dmj/wl-send-html-message-toggle ()
  "Toggle sending of html message."
  (interactive)
  (setq dmj/wl-send-html-message-toggled-p
        (if dmj/wl-send-html-message-toggled-p
            nil "HTML"))
  (message "Sending html message toggled %s"
           (if dmj/wl-send-html-message-toggled-p
               "on" "off")))

(defun dmj/wl-send-html-message-draft-init ()
  "Create buffer local settings for maybe sending html message."
  (unless (boundp 'dmj/wl-send-html-message-toggled-p)
    (setq dmj/wl-send-html-message-toggled-p nil))
  (make-variable-buffer-local 'dmj/wl-send-html-message-toggled-p)
  (add-to-list 'global-mode-string
               '(:eval (if (eq major-mode 'wl-draft-mode)
                           dmj/wl-send-html-message-toggled-p))))

(defun dmj/wl-send-html-message-maybe ()
  "Maybe send this message as html message.

If buffer local variable `dmj/wl-send-html-message-toggled-p' is
non-nil, add `dmj/wl-send-html-message' to
`mime-edit-translate-hook'."
  (if dmj/wl-send-html-message-toggled-p
      (add-hook 'mime-edit-translate-hook 'dmj/wl-send-html-message)
    (remove-hook 'mime-edit-translate-hook 'dmj/wl-send-html-message)))

(add-hook 'wl-draft-reedit-hook 'dmj/wl-send-html-message-draft-init)
(add-hook 'wl-mail-setup-hook 'dmj/wl-send-html-message-draft-init)
(add-hook 'wl-draft-send-hook 'dmj/wl-send-html-message-maybe)

;; --------


(defun my-wl-highlight-hook (beg end len);   )(and nil
  (let ((beginning (save-excursion
		    (goto-char beg)
		    (re-search-backward "^" nil t)))
	(ending (save-excursion
		  (goto-char end)
		  (re-search-forward "$" nil t))))
    (put-text-property beginning ending 'face nil)
    (wl-highlight-message beginning ending t nil)
    (wl-highlight-message beginning ending t t)
    ))

(defun my-wl-draft-install-change-hooks ()
  (make-local-variable 'after-change-functions)
  (add-hook 'after-change-functions 'my-wl-highlight-hook))

(add-hook 'wl-draft-mode-hook 'my-wl-draft-install-change-hooks)

(and nil
(defun my-wl-draft-remove-change-hooks ()
  (remove-hook 'after-change-functions 'my-wl-highlight-hook))

(add-hook 'wl-draft-send-hook 'my-wl-draft-remove-change-hooks)

(defadvice wl-draft-generate-clone-buffer (around wl-draft-disable-highlight preactivate)
   (remove-hook 'wl-draft-mode-hook 'my-wl-draft-install-change-hooks)
   ad-do-it
   (add-hook 'wl-draft-mode-hook 'my-wl-draft-install-change-hooks)))

  (defadvice split-window (before wl-split-horizontally disable)
    "When the system is going to split the summary buffer window
to show a message, I want to split it horizontally!  The default
of splitting vertically (i.e. with a horizontal divider) leaves
me looking at really long lines through really narrow spaces,
which kinda blows."
        (ad-set-arg 2 t)
        (ad-set-arg 1 nil)
        )

  (defadvice wl-message-select-buffer (around setup-wl-split-horizontally activate protect)
    "See split-window advice \"wl-split-horizontally\".  Make sure it only applies 
when we need it."
    (ad-enable-advice 'split-window 'before 'wl-split-horizontally)
    (ad-activate 'split-window)
    ad-do-it
    (ad-disable-advice 'split-window 'before 'wl-split-horizontally)
    (ad-activate 'split-window)
    )

(setq-default mime-transfer-level 8)

(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))

(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(require 'mairix)

(add-to-list 'mairix-display-functions '(wl mairix-wl-display))
(add-to-list 'mairix-get-mail-header-functions '(wl mairix-wl-fetch-field))

(setq mairix-wl-search-folder-prefix "%")

(defun mairix-wl-display (folder)
  "Display FOLDER using Wanderlust."
  ;; If Wanderlust is running (Folder buffer exists)...
  (if (get-buffer wl-folder-buffer-name)
      ;; Check if we are in the summary buffer, close it and
      ;; goto the Folder buffer
      (if (string= (buffer-name) wl-summary-buffer-name)
          (progn
            (wl-summary-exit t)
            (set-buffer (get-buffer wl-folder-buffer-name))))
    ;; Otherwise Wanderlust is not running so start it
    (wl))
  ;; From the Folder buffer goto FOLDER first stripping off mairix-file-path
  ;; to leave the wl folder name
  (when (string-match
         (concat (regexp-quote (expand-file-name mairix-file-path)) "\\.*\\(.*\\)")
         folder)
    (wl-folder-goto-folder-subr
     (concat mairix-wl-search-folder-prefix (match-string 1 folder)))))


(defun mairix-wl-fetch-field (field)
  "Get mail header FIELD for current message using Wanderlust."
  (when wl-summary-buffer-elmo-folder
    (let ((raw-field
          (elmo-message-field
           wl-summary-buffer-elmo-folder
           (wl-summary-message-number)
           (intern (downcase field)))))
      (if (listp raw-field) (car raw-field) raw-field))))

(defvar my-mairix-map
  (let ((map (make-sparse-keymap)))
    (define-key wl-summary-mode-map "\M-m" map)
    map)
  "Sub-keymap in the my keymap for the mairix commands")

(define-key my-mairix-map "m" 'mairix-search)
(define-key my-mairix-map "w" 'mairix-widget-search)
(define-key my-mairix-map "u" 'mairix-update-database)
(define-key my-mairix-map "f" 'mairix-search-from-this-article)
(define-key my-mairix-map "t" 'mairix-search-thread-this-article)
(define-key my-mairix-map "b" 'mairix-widget-search-based-on-article)
(define-key my-mairix-map "s" 'mairix-save-search)
(define-key my-mairix-map "i" 'mairix-use-saved-search)
(define-key my-mairix-map "e" 'mairix-edit-saved-searches)

;;; Use ~/.mailrc
(setq wl-address-init-function 'my-wl-address-init)
(defun my-wl-address-init ()
  (wl-local-address-init)
  (setq wl-address-completion-list
        (append wl-address-completion-list (build-mail-aliases))))

;;; Stuff from hgw-init.el

(require 'signature)
(setq signature-insert-at-eof t)
(setq signature-delete-blank-lines-at-eof t)


(setq global-mode-string
      (cons
       '(wl-modeline-biff-status
         wl-modeline-biff-state-on
         wl-modeline-biff-state-off)
       global-mode-string))

;; ----------------------------------------------------------------------------
;;; Extension Functions

(defun wl-draft-config-sub-signature (content)
  "Insert the signature at the end of the MIME message."
  (let ((signature-insert-at-eof nil) ; believe it or not, having this
                                      ; set to t interferes with
                                      ; wl-draft putting the signature
                                      ; at the real end of the buffer.
        (signature-file-name content))
    (goto-char (mime-edit-content-end))
    (insert-signature)))

(require 'bbdb)

(defun my-bbdb-wl-refile-alist ()
  "Add the `From To' refile to `folder' entries from the BBDB to the
`wl-refile-rule-alist'."
  (interactive)
  (let ((from-rule-alist (list '("From" "To")))
        (records (bbdb-records))
        (record))
    (while records
      (setq record (car records))
      (let ((email-addrs (bbdb-record-net record))
            (folder (bbdb-record-getprop record 'folder))
            (email-addr))
        (if folder
            (progn
              (while email-addrs
                (setq email-addr (car email-addrs))
                (setq from-rule-alist
                      (append from-rule-alist (list (cons email-addr folder))))
                (setq email-addrs (cdr email-addrs))))))
      (setq records (cdr records)))
    (setq wl-refile-rule-alist
          (append wl-general-refile-rule-alist (list from-rule-alist)))
    ))


(add-hook
 'wl-init-hook
 '(lambda ()
;    (set-frame-position (selected-frame) 663 0)
;    (set-frame-height (selected-frame) 70)
;    (set-frame-width (selected-frame) 114)
;    (my-wl-zen-smtp-server) ;; Set the default smtp server to zen
;    (my-bbdb-wl-refile-alist) ;; Add the BBDB refiling folders
;    (run-with-idle-timer 30 t 'my-wl-auto-save-draft-buffers)

    ;; Add support for (signature . "filename")
    (unless (assq 'signature wl-draft-config-sub-func-alist)
      (wl-append wl-draft-config-sub-func-alist
                 '((signature . wl-draft-config-sub-signature))))

    (defun mime-edit-insert-signature (&optional arg)
      "Redefine to insert a signature file directly, not as a tag."
      (interactive "P")
      (insert-signature arg))

    ;; Keep track of recently used Email addresses
    ;;(recent-addresses-mode 1)
    ))



(add-hook
 'wl-folder-mode-hook
 '(lambda ()
    (hl-line-mode t)
    (local-set-key "\M-m" 'mairix-search)
    ))

(add-hook
 'wl-summary-mode-hook
 '(lambda ()
    (hl-line-mode t)

    ;; Key bindings
    (local-set-key "D" 'wl-thread-delete)
    (local-set-key "b" 'wl-summary-resend-bounced-mail)
    (local-set-key "\C-d" 'my-wl-summary-delete-and-move-prev)
    (local-set-key "\C-cQ" 'my-wl-delete-whole-folder)
    (local-set-key "\C-cb" 'my-bbdb-wl-refile-alist)
    ;; I'm way too prone to doing this one by mistake
    ;;
    ;; (local-set-key "\C-a"
    ;;                '(lambda ()
    ;;                   (interactive)
    ;;                   (wl-summary-reply-with-citation 1)))
    ;;(local-set-key "\M-m" 'mairix-search)
    ))

(add-hook
 'wl-summary-exec-hook
 '(lambda ()
    ;; Synchronise the folder with the server after executing the summary
    ;; operation
    (wl-summary-sync-update)
    ))

(add-hook
 'wl-message-buffer-created-hook
 '(lambda ()
    (setq truncate-lines nil) ;; Fold over-lenght lines
    ))


;;(add-hook
;; 'wl-draft-mode-hook
;; '(lambda ()
    ;; Key bindings
    ;(local-set-key "\C-c\C-k" 'my-wl-draft-kill-force)
;;    ))

;; Add lots of goodies to the mail setup
(add-hook 'wl-mail-setup-hook 'my-mail-setup)

;; This is needed because mime-setup-enable-inline-html forces the
;; score for html to 3
(eval-after-load "semi-setup"
  '(set-alist 'mime-view-type-subtype-score-alist '(text . html) 0))

(add-hook
 'mime-view-mode-hook
 '(lambda ()
    "Change [mouse-2] to drag-scroll rather than follow link.
Set [(return)] to execute the mime-button.
Set the `f' key to run `find-file' on the attached entity.
;Set the `C-f' key to run `find-file-at-point'.
Set the `w' key to run `wget'.
Set the `j' key to run `mime-preview-quit'."
    ;; Key bindings
    (local-set-key [down-mouse-2] 'mouse-drag-drag)
    (local-set-key [(return)] 'my-mime-button-exec)
    (local-set-key [?f] 'my-mime-find-file-current-entity)
    ;; (local-set-key [(control ?f)] 'find-file-at-point)
    (local-set-key [?w] 'wget)
    (local-set-key [?o] 'wget-open)
    (local-set-key [?j] 'mime-preview-quit)
    (local-set-key [?s] '(lambda ()
                           (interactive)
                           (mime-preview-quit)
                           (wl-summary-sync)))
    ))

(add-hook
 'wl-biff-notify-hook
 '(lambda ()
    (my-wl-update-current-summaries)
    ))

;; Automatically add mailing list fields
(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)

;; Smilies
(add-hook
 'wl-message-redisplay-hook
 '(lambda () (smiley-region (point-min) (point-max))
    ))

(add-hook
 'wl-draft-cited-hook
 '(lambda ()
     (and (featurep 'smiley-mule)
          (smiley-toggle-buffer -1))
     ))

;; ----------------------------------------------------------------------------
;;; User Functions

(defun my-wl-draft-kill-force ()
  (interactive)
  (wl-draft-kill t))

(defun my-wl-delete-whole-folder ()
  (interactive)
  (wl-summary-target-mark-all)
  (wl-summary-target-mark-delete)
  (wl-summary-exec)
  (wl-summary-exit))

(defun my-wl-check-mail-primary ()
  (interactive)
  (unless (get-buffer wl-folder-buffer-name)
    (wl))
  (delete-other-windows)
  (switch-to-buffer wl-folder-buffer-name)
  (goto-char (point-min))
  (next-line 1)
  (wl-folder-jump-to-current-entity))

(defun my-wl-auto-save-draft-buffers ()
  (let ((buffers (wl-collect-draft)))
    (save-excursion
      (while buffers
        (set-buffer (car buffers))
        (if (buffer-modified-p) (wl-draft-save))
        (setq buffers (cdr buffers))))))

(defun my-wl-update-current-summaries ()
  (let ((buffers (wl-collect-summary)))
    (while buffers
      (with-current-buffer (car buffers)
        (save-excursion
          (wl-summary-sync-update)))
      (setq buffers (cdr buffers)))))

(defun my-wl-summary-delete-and-move-prev ()
  (interactive)
  (let (wl-summary-move-direction-downward)
    (call-interactively 'wl-summary-delete)))

(defun my-wl-summary-goto-to-folder (folder)
  "Goto FOLDER from the summary buffer after closing it."
  (wl-summary-exit t)
  (set-buffer (get-buffer wl-folder-buffer-name))
  (wl-folder-goto-folder-subr folder))

(defun my-wl-goto-to-folder (folder)
  "Goto FOLDER from either the folders or summary buffer after closing it."
  (if (string= (buffer-name) wl-summary-buffer-name)
      (my-wl-summary-goto-to-folder search-folder)
    (wl-folder-goto-folder-subr search-folder)))

(defun my-clean-mime-reply ()
  "Clean-up the citation in replies, removing unnecessary entities."
  (interactive)
  (require 'misc-cmds)
  ;; Find and strip the first tag, indicating the start of the
  ;; cited message
  (when (re-search-forward "^> \\[1" nil t)
    (beginning-of-line)
    (delete-lines 1)
    (while (or (looking-at "^> *$")
               (looking-at "^> \\[[1-9]"))
      (delete-lines 1))
    (when (re-search-forward "^> \\[[1-9][\\. ]" nil t)
      (beginning-of-line)
      (let ((pt (point)))
        (re-search-forward "^$")
        (delete-region pt (point)))))
  ;; Now find the tag that ends the first section, and strip off
  ;; everything from there to the end of the message (including any
  ;; other sections that got cited)
  (goto-char (point-max))
  (when (re-search-backward "^> +[^ ]" nil t)
    (beginning-of-line)
    (let ((pt (point)))
      (goto-char (point-max))
      (if (re-search-backward "^> *$" pt t)
          (progn
            (beginning-of-line)
            (while (looking-at "^> *$")
              (delete-lines 1)
              (forward-line -1))
            (forward-line 1)
            (delete-lines 1))
        (goto-char (point-max))
        (re-search-backward "^$")
        (delete-lines 1)))))

(defun wl-rehilight ()
  "Re-highlight message."
  (let ((beg (point-min))
        (end (point-max)))
    (put-text-property beg end 'face nil)
    (wl-highlight-message beg end t)))

(defun my-mail-setup ()
  "Set up appropriate modes for writing Email
and clean-up citation for replies."
  (interactive)
   ;; Fold over-lenght lines
  (setq truncate-lines nil)
  (turn-on-auto-fill)
;;  (ignore-errors
;;    (flyspell-mode t))
  (wl-draft-config-exec)
  ;; Switch on the completion selection mode
  ;; and set the default completion-selection to bbdb
;  (completion-selection-mode t)
;  (completion-selection-set 'complete-bbdb)
  ;; Clean up reply citation
  (save-excursion
    ;; Goto the beginning of the message body
    (mail-text)
    ;; If the message body starts with "Dear " assume it is a reply
    ;; and clean the citation
    (when (looking-at "^Dear ")
      (my-clean-mime-reply))))

(defun my-mime-save-content-find-file (entity &optional situation)
  "Save the attached mime ENTITY and load it with `find-file-other-frame'
so that the appropriate emacs mode is selected according to the file extension."
  (let* ((name (or (mime-entity-safe-filename entity)
                   (format "%s" (mime-entity-media-type entity))))
         (dir (if (eq t mime-save-directory)
                  default-directory
                mime-save-directory))
         (filename (expand-file-name
                    (file-name-nondirectory name) temporary-file-directory)))
    (mime-write-entity-content entity filename)
    (select-frame (make-frame))
    (find-file filename)
    ))

(defun my-mime-view-emacs-mode (entity &optional situation)
  "Internal method for mime-view to display the mime ENTITY in a buffer with an
appropriate emacs mode."
  (let ((buf (get-buffer-create
              (format "%s-%s" (buffer-name) (mime-entity-number entity)))))
    (with-current-buffer buf
      (setq buffer-read-only nil)
      (erase-buffer)
      (mime-insert-text-content entity)
      ;;(mule-caesar-region (point-min) (point-max))
      ;; Set emacs mode here
      (set-buffer-modified-p nil)
      )
    (let ((win (get-buffer-window (current-buffer))))
      (or (eq (selected-window) win)
          (select-window (or win (get-largest-window)))
          ))
    (view-buffer buf)
    (goto-char (point-min))
    ))

(defun my-mime-find-file-current-entity ()
  "Save the current mime entity and load it with `find-file-other-frame'
so that the appropriate emacs mode is selected according to the file extension."
  (interactive)
  (let ((entity (get-text-property (point) 'mime-view-entity)))
    (if entity
        (my-mime-save-content-find-file entity)))
  )

(require 'elmo)

(defun my-bbdb-insert-folder ()
  "Interactively select the destination folder and store in BBDB."
  (interactive)
  (require 'bbdb-com)
  (let* ((record (or (bbdb-current-record t)
                     (error "current record unexists!")))
         (name (wl-summary-read-folder my-wl-default-filing-folder))
         (folder-path (wl-folder-get-elmo-folder name)))
    (bbdb-insert-new-field
     record 'folder (elmo-folder-name-internal folder-path)))
  ;; Update the wl refiling database
  (my-bbdb-wl-refile-alist))

(defun my-mime-button-exec ()
  "Execute the button under point without using the mouse."
  (interactive)
  (let (buf point func data)
    (save-window-excursion
      (setq buf (current-buffer)
            point (point)
            func (get-text-property (point) 'mime-button-callback)
            data (get-text-property (point) 'mime-button-data)
            ))
    (save-excursion
      (set-buffer buf)
      (goto-char point)
      (if func
          (apply func data))
      )))

  (eval-after-load "semi-setup"
    '(set-alist 'mime-view-type-subtype-score-alist '(text . html) 0))


;; ----------------------------------------------------------------------------
;;; Key-bindings

(global-set-key "\C-xm" 'my-wl-check-mail-primary)
;;(define-key bbdb-mode-map [(control f)] 'my-bbdb-insert-folder)

;; -----------
(require 'mime-w3m)
