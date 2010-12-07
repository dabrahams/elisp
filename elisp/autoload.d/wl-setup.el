;; Fill messages, thanks to Ron Isaacson <Ron.Isaacson-AT-morganstanley.com>
;;
(require 'mime-conf)
(require 'wl-summary)

(require 'filladapt)
(require 'org-wl)

(require 'wl-highlight)

(loop for x in wl-highlight-citation-face-list do 
      (set-face-background x "#F0F0F0"))

;;; ====
;;; Adjustments to be able to display faulty jpg MIME type
;;; per [[http://news.gmane.org/find-root.php?message_id=%3c82bp6fjj71.wl%25kzhr%40d1.dion.ne.jp%3e][Email from Kazuhiro Ito: Re: Counfounding MIME]]
(eval-after-load "mime-image"
  '(let ((rule '(image jpg jpeg)))
     (ctree-set-calist-strictly
      'mime-preview-condition
      (list (cons 'type (car rule))(cons 'subtype (nth 1 rule))
	    '(body . visible)
	    (cons 'body-presentation-method #'mime-display-image)
	    (cons 'image-format (nth 2 rule))))))

;;; ====

;; From [[http://mid.gmane.org/87mxqjn7un.wl%25ucecesf@ucl.ac.uk][Eric S. Fraga]]
;; use visual-line-mode for displaying message.  This is a customization of some
;; code posted by lloyd zusman on the wanderlust mailing list
(defun my-summary-redisplay-hook () 
  (save-excursion
    (save-restriction
      (set-buffer wl-message-buffer)
      (save-excursion
	;; (visual-line-mode t) ;; code for reformating the message buffer goes here
	(setq word-wrap t)
	)            
      )))

(add-hook 'wl-summary-redisplay-hook 'my-summary-redisplay-hook)

;; to have text flowing automatically in display of emails in wanderlust
(autoload 'fill-flowed "flow-fill")
(defun flow-fill-mime-display ()
 	    (when (string= "flowed"
 			   (cdr (assoc "format"
 				       (mime-content-type-parameters
 					(mime-entity-content-type entity)))))
 	      (fill-flowed)))
(add-hook 'mime-display-text/plain-hook 'flow-fill-mime-display)

;;; ====

(defun wl-summary-fill-message (all)
  (interactive "P")
  (if (and wl-message-buffer (get-buffer-window wl-message-buffer))
      (progn
        (wl-summary-toggle-disp-msg 'on)
        (save-excursion
          (with-current-buffer wl-message-buffer
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
              (fill-region (point-min) (point-max))))))
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

;; From http://emacs-fu.blogspot.com/2009/09/wanderlust-tips-and-tricks.html

(setq
  wl-forward-subject-prefix "Fwd: " )    ;; use "Fwd: " not "Forward: "

;;;--------
(defun my-wl-highlight-hook (beg end len);   )(and nil
  (save-match-data
    (let ((beginning (save-excursion
                       (goto-char beg)
                       (re-search-backward "^" nil t)))
          (ending (save-excursion
                    (goto-char end)
                    (re-search-forward "\\(\n\\|$\\)" nil t))
                    ))
      (put-text-property beginning ending 'face nil)
      (wl-highlight-message beginning ending t nil)
      (wl-highlight-message beginning ending t t)
      )))

(defun my-wl-draft-install-change-hooks ()
  (make-local-variable 'after-change-functions)
  (add-hook 'after-change-functions 'my-wl-highlight-hook)
)

(add-hook 'wl-draft-mode-hook 'my-wl-draft-install-change-hooks)

(and nil
(defun my-wl-draft-remove-change-hooks ()
  (remove-hook 'after-change-functions 'my-wl-highlight-hook))

(add-hook 'wl-draft-send-hook 'my-wl-draft-remove-change-hooks)

(defadvice wl-draft-generate-clone-buffer (around wl-draft-disable-highlight preactivate)
   (remove-hook 'wl-draft-mode-hook 'my-wl-draft-install-change-hooks)
   ad-do-it
   (add-hook 'wl-draft-mode-hook 'my-wl-draft-install-change-hooks)))


;;
;; Forcing horizontal window splitting
;;
(when t

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

(add-hook 'wl-message-redisplay-hook
          (lambda () (let ((growth (- 80 (window-width)))) (> growth 0) (enlarge-window-horizontally growth))))
)
;;

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


(when nil
;;; Shows envelopes in the mode line, but I haven't really got biff
;;; working yet and not sure I'd want this anyhow.

(setq global-mode-string
      (cons
       '(wl-modeline-biff-status
         wl-modeline-biff-state-on
         wl-modeline-biff-state-off)
       global-mode-string))
)

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
;;    (local-set-key "\M-m" 'mairix-search)
    ))

(add-hook
 'wl-summary-mode-hook
 '(lambda ()
    (hl-line-mode t)

    ;; Key bindings
    (local-set-key "D" 'wl-thread-delete)
    (local-set-key "d" 'wl-summary-delete)
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


;; ----------------------------------------------------------------------------
;;; Key-bindings

(global-set-key "\C-xM" 'my-wl-check-mail-primary)
;;(define-key bbdb-mode-map [(control f)] 'my-bbdb-insert-folder)



;; ------------

(require 'wl-gravatar)
(setq wl-highlight-x-face-function 'wl-gravatar-insert)
(setq gravatar-directory "~/.cache/emacs-gravatar/")
(setq gravatar-unregistered-icon 'identicon)
(setq wl-gravatar-retrieve-once t)


;; ------------------------------------------------

(luna-define-method elmo-folder-synchronize ((folder elmo-folder)
					     &optional
					     disable-killed
					     ignore-msgdb
					     no-check
					     mask)
  (let ((old-msgdb (elmo-folder-msgdb folder))
	(killed-list (elmo-folder-killed-list-internal folder))
	(flag-table (elmo-flag-table-load (elmo-folder-msgdb-path folder)))
	(before-append t))
    (when ignore-msgdb
      (elmo-msgdb-flag-table (elmo-folder-msgdb folder) flag-table)
      (elmo-folder-clear folder (not disable-killed)))
    (unless no-check (elmo-folder-check folder))
    (condition-case nil
	(let ((killed-list (elmo-folder-killed-list-internal folder))
	      diff-new diff-del
	      delete-list new-list new-msgdb crossed)
	  (message "Checking folder diff...")
          (if (and mask
                   (eq 'elmo-imap4-folder (luna-class-name folder)))
              (elmo-set-list
               '(diff-new diff-del)
               (elmo-list-diff
                (elmo-imap4-list 
                 folder
                 (concat "UID "
                         (mapconcat (lambda (uid)
                                      (format "%d" uid))
                                    mask ",")))
                (elmo-list-filter
                 mask 
                 (elmo-folder-list-messages folder nil 'in-msgdb))))
            (elmo-set-list
             '(diff-new diff-del)
             (elmo-list-diff (elmo-folder-list-messages folder)
                             (elmo-folder-list-messages folder nil 'in-msgdb))))
	  (when diff-new
	    (setq diff-new (sort diff-new #'<))
	    (unless disable-killed
	      (setq diff-new (elmo-living-messages diff-new killed-list)))
	    (when (and mask (not ignore-msgdb))
	      (setq diff-new (elmo-list-filter mask diff-new))))
	  (message "Checking folder diff...done")
	  (setq new-list (elmo-folder-confirm-appends folder diff-new))
	  ;; Append to killed list as (MIN-OF-DISAPPEARED . MAX-OF-DISAPPEARED)
	  (when (not (eq (length diff-new)
			 (length new-list)))
	    (let* ((diff (elmo-list-diff diff-new new-list))
		   (disappeared (sort (car diff) #'<)))
	      (when disappeared
		(elmo-folder-kill-messages-range folder
						 (car disappeared)
						 (elmo-last disappeared)))))
	  (setq delete-list diff-del)
	  (if (and (null diff-new) (null diff-del))
	      (progn
		(elmo-folder-update-number folder)
		(elmo-folder-process-crosspost folder)
		0)			; `0' means no updates.
	    (when delete-list
	      (elmo-folder-detach-messages folder delete-list))
	    (when new-list
	      (elmo-msgdb-out-of-date-messages (elmo-folder-msgdb folder))
	      (setq new-msgdb (elmo-folder-msgdb-create
			       folder new-list flag-table))
	      ;; Clear flag-table
	      (if (elmo-folder-persistent-p folder)
		  (elmo-flag-table-save (elmo-folder-msgdb-path folder)
					nil))
	      (setq before-append nil)
	      (setq crossed (elmo-folder-append-msgdb folder new-msgdb))
	      ;; process crosspost.
	      ;; Return a cons cell of (NUMBER-CROSSPOSTS . NEW-FLAG-ALIST).
	      (elmo-folder-process-crosspost folder))
	    ;; return value.
	    (or crossed 0)))
      (quit
       ;; Resume to the original status.
       (if before-append (elmo-folder-set-msgdb-internal folder old-msgdb))
       (elmo-folder-set-killed-list-internal folder killed-list)
       nil))))

(defun egh:wl-all-folder () "%[Gmail]/All Mail")

(defvar egh:wl-summary-prev-folder-name nil)
(defvar dwa:wl-summary-prev-message-id nil)

(defun dwa:wl-current-thread-location ()
  "Return a pair consisting of the message-id of the current
message and of the root of its thread (both surrounded by <...>)"
  (save-excursion
    (wl-summary-set-message-buffer-or-redisplay)
    (set-buffer (wl-message-get-original-buffer))

    (let ((message-id (std11-field-body "Message-Id")))
     ;; The thread root is the first UID in References, if any, or
     ;; else is the current message
      (cons message-id
            (car (split-string (or (std11-field-body "References") message-id)))))
    ))

(defun dwa:wl-thread-root-folder (thread-root)
  (let ((root-uid (substring thread-root 1 -1)))
         (concat "/message-id:\"" thread-root
                 "\"|references:\"" thread-root
                 "\"/" (egh:wl-all-folder))))

(defun egh:wl-summary-visit-conversation (&optional close)
 (interactive "P")
 (if close
     (if egh:wl-summary-prev-folder-name
         (progn
           (wl-summary-goto-folder-subr egh:wl-summary-prev-folder-name
                                        'no-sync nil nil t)
           (wl-summary-jump-to-msg-by-message-id dwa:wl-summary-prev-message-id))
       (message "No previous folder to visit."))

   (let* ((thread-location (dwa:wl-current-thread-location))
          (cur-message-id (car thread-location))
          (thread-folder (dwa:wl-thread-root-folder (cdr thread-location)))
          (prev-folder-name wl-summary-buffer-folder-name)
         )
     (wl-summary-goto-folder-subr thread-folder 'update nil nil t)
     (wl-summary-jump-to-msg-by-message-id cur-message-id)
     (setq egh:wl-summary-prev-folder-name prev-folder-name
           dwa:wl-summary-prev-message-id cur-message-id)
     (make-local-variable 'egh:wl-summary-prev-folder-name)
     (make-local-variable 'dwa:wl-summary-prev-message-id)
     )))



(defadvice org-wl-store-link-message (after dwa:org-wl-store-link activate protect)
  (if (string= (substring ad-return-value 0 3) "wl:")
      (let* ((thread-location (dwa:wl-current-thread-location))
             (message-id (car thread-location))
             (folder-name (dwa:wl-thread-root-folder (cdr thread-location)))
             (message-id-no-brackets (org-remove-angle-brackets message-id))
             (link (org-make-link "wl:" folder-name "#" message-id-no-brackets))
             )
        (org-add-link-props :link link)
        (setq ad-return-value link)
    )))

     ;; Use `bogofilter' as spam back end
     ;; Set `scheme' here as the spam filter you will use.
     ;; *Note Spam Filter Processors::.
     (setq elmo-spam-scheme 'bogofilter)
     (require 'wl-spam)

(define-key wl-summary-mode-map "X" 'egh:wl-summary-visit-conversation)

(when nil

(require 'elmo-imap4)

(defun elmo-imap4-search2-build-full-command (search)
  "Process charset at beginning of SEARCH and build a full IMAP
search command."
  (let ((charset (car search)))
    (append '("uid search ")
            (if (not (null charset))
                (list "CHARSET " charset))
            '(" ")
            (cdr search))))

(defun elmo-imap4-search2-perform (session search-or-msg-ids)
  "Perform a search in an IMAP session."
  (if (numberp (car search-or-msg-ids))
      search-or-msg-ids
    (elmo-imap4-response-value
     (elmo-imap4-send-command-wait
      session
      (elmo-imap4-search2-build-full-command search-or-msg-ids))
     'search)))

(defun elmo-imap4-search2-generate-vector (folder filter from-msgs)
  "Generate an IMAP search or a list of message ids from a search
condition vector."
  (let ((search-key (elmo-filter-key filter))
	(imap-search-keys '("bcc" "body" "cc" "from" "subject" "to"
			    "larger" "smaller" "flag")))
    (cond
     ((string= "last" search-key)
      (let ((numbers (or from-msgs (elmo-folder-list-messages folder)))
            (length (length from-msgs)))
	(nthcdr (max (- (length numbers)
			(string-to-number (elmo-filter-value filter)))
		     0)
		numbers)))
     ((string= "first" search-key)
      (let* ((numbers (or from-msgs (elmo-folder-list-messages folder)))
	     (rest (nthcdr (string-to-number (elmo-filter-value filter) )
			   numbers)))
	(mapcar '(lambda (x) (delete x numbers)) rest)
	numbers))
     ((string= "flag" search-key)
      (elmo-imap4-folder-list-flagged
       folder (intern (elmo-filter-value filter))))
     ((or (string= "since" search-key)
	  (string= "before" search-key))
      (list
       nil
       (if (eq (elmo-filter-type filter)
               'unmatch)
           "not " "")
       (concat "sent" search-key)
       " "
       (elmo-date-get-description
        (elmo-date-get-datevec
         (elmo-filter-value filter)))))
     (t
      (let ((charset (elmo-imap4-detect-search-charset
                      (elmo-filter-value filter))))
        (list
         (elmo-imap4-astring
          (symbol-name charset))
         (if (eq (elmo-filter-type filter)
                 'unmatch)
             "not " "")
         (format "%s%s "
                 (if (member (elmo-filter-key filter) imap-search-keys)
                     ""
                   "header ")
                 (elmo-filter-key filter))
         (elmo-imap4-astring
          (encode-mime-charset-string
           (elmo-filter-value filter) charset))))))))

(defun elmo-imap4-search2-mergeable? (a b)
  "Return t if A and B are two mergeable IMAP searches."
  (let ((cara (car a))
        (carb (car b)))
    (and (not (numberp cara))
         (not (numberp carb))
         (or (null cara)
             (null carb)
             (equal cara carb)))))

(defun elmo-imap4-search2-mergeable-charset (a b)
  "Return the charset of two searches."
  (or (car a)
      (car b)))

(defun elmo-imap4-search2-generate-uid (msgs)
  "Return a search for a set of msgs."
  (list nil 
        (concat "uid " 
                (cdr (car
                      (elmo-imap4-make-number-set-list msgs))))))
  
(defun elmo-imap4-search2-generate-and (a b)
  "AND two searches."
  (if (elmo-imap4-search2-mergeable? a b)
      (append (list (elmo-imap4-search2-mergeable-charset a b))
              (cdr a) '(" ") (cdr b))
    (elmo-list-filter (elmo-imap4-search2-perform session a) 
                      (elmo-imap4-search2-perform session b))))

(defun elmo-imap4-search2-generate-or (a b)
  "OR two searches."
  (if (elmo-imap4-search2-mergeable? a b)
      (append (list (elmo-imap4-search2-mergeable-charset a b))
              '("OR " "(") (cdr a) '(")" " " "(") (cdr b) '(")"))
    (elmo-uniq-list (append (elmo-imap4-search2-perform session a)
                            (elmo-imap4-search2-perform session b)))))
  
(defun elmo-imap4-search2-generate (folder condition from-msgs)
  (if (vectorp condition)
      (elmo-imap4-search2-generate-vector folder condition from-msgs)
    (let ((a (elmo-imap4-search2-generate folder (nth 1 condition)
                                          from-msgs))
          (b (elmo-imap4-search2-generate folder (nth 2 condition)
                                          from-msgs)))
      (cond
       ((eq (car condition) 'and)
        (elmo-imap4-search2-generate-and a b))
       ((eq (car condition) 'or)
        (elmo-imap4-search2-generate-or a b))))))

(if (not (boundp 'elmo-imap4-search-internal-orig))
    (fset 'elmo-imap4-search-internal-orig
          (symbol-function 'elmo-imap4-search-internal)))

(defun elmo-imap4-search2-internal (folder session condition from-msgs)
  (let* ((imap-search
          (if from-msgs
              (elmo-imap4-search2-generate-and
               (elmo-imap4-search2-generate-uid from-msgs)
               (elmo-imap4-search2-generate folder condition from-msgs))
            (elmo-imap4-search2-generate folder condition from-msgs))))
    (elmo-imap4-search2-perform session imap-search)))

(defun elmo-imap4-search-internal (folder session condition from-msgs)
  (elmo-imap4-search2-internal folder session condition from-msgs))

;; (fset 'elmo-imap4-search-internal
;;   (symbol-function 'elmo-imap4-search-internal-orig))
)