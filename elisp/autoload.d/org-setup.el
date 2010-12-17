(add-hook 'org-mode-hook
;; org mode overrides my standard meaning for `C-,' by default.  Get it back.
 (lambda ()
  (local-set-key [(control ?,)] 'backward-word)
  ))

(add-hook 'org-capture-mode-hook
          (lambda ()
            (define-key mode-specific-map [?f] 'org-capture-refile)
            ;; Why doesn't this one seem to take effect?
            ;; (define-key mode-specific-map [(control ?f)] 'org-capture-refile)
            (define-key org-capture-mode-map "\C-c\C-f" 'org-capture-refile)
            ))

(define-key mode-specific-map [?c] 'compile)
(define-prefix-command 'org-todo-state-map)
(define-key org-mode-map "\C-cx" 'org-todo-state-map)
;; (define-key org-mode-map "\M-/" 'org-complete)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(defun save-org-mode-files ()
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (eq major-mode 'org-mode)
	(if (and (buffer-modified-p) (buffer-file-name))
	    (save-buffer))))))

(run-with-idle-timer 25 t 'save-org-mode-files)

(defun my-org-push-mobile ()
  (interactive)
  (with-current-buffer (find-file-noselect "~/Dropbox/todo.txt")
    (org-mobile-push)))

(run-with-idle-timer 600 t 'my-org-push-mobile)

(defun my-org-convert-incoming-items ()
 (interactive)
 (with-current-buffer (find-file-noselect org-mobile-inbox-for-pull)
   (goto-char (point-min))
   (while (re-search-forward "^\\* " nil t)
     (goto-char (match-beginning 0))
     (insert ?*)
     (forward-char 2)
     (insert "TODO ")
     (goto-char (line-beginning-position))
     (forward-line)
     (insert
      (format
	"   SCHEDULED: %s
  :PROPERTIES:
  :ID:       %s   :END:
  "
	(with-temp-buffer (org-insert-time-stamp (current-time)))
	(shell-command-to-string "uuidgen"))))
   (let ((tasks (buffer-string)))
     (erase-buffer)
     (save-buffer)
     (kill-buffer (current-buffer))
     (with-current-buffer (find-file-noselect "~/Dropbox/todo.txt")
	(save-excursion
	  (goto-char (point-min))
	  (search-forward "* Inbox")
	  (goto-char (match-beginning 0))
         (forward-line 1)
	  (insert tasks))))))

(add-hook 'org-mobile-post-pull-hook 'my-org-convert-incoming-items)

(defvar org-my-archive-expiry-days 1
  "The number of days after which a completed task should be auto-archived.
This can be 0 for immediate, or a floating point value.")

(defconst org-my-ts-regexp "[[<]\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} [^]>\r\n]*?\\)[]>]"
  "Regular expression for fast inactive time stamp matching.")

(defun org-my-closing-time ()
  (let* ((state-regexp
	  (concat "- State \"\\(?:" (regexp-opt org-done-keywords)
		  "\\)\"\\s-*\\[\\([^]\n]+\\)\\]"))
	 (regexp (concat "\\(" state-regexp "\\|" org-my-ts-regexp "\\)"))
	 (end (save-excursion
		(outline-next-heading)
		(point)))
	 begin
	 end-time)
    (goto-char (line-beginning-position))
    (while (re-search-forward regexp end t)
      (let ((moment (org-parse-time-string (match-string 1))))
	(if (or (not end-time)
		(time-less-p (apply #'encode-time end-time)
			     (apply #'encode-time moment)))
	    (setq end-time moment))))
    (goto-char end)
    end-time))

(defun org-my-archive-done-tasks ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((done-regexp
	   (concat "^\\*\\* \\(" (regexp-opt org-done-keywords) "\\) ")))
      (while (re-search-forward done-regexp nil t)
	(if (>= (time-to-number-of-days
		 (time-subtract (current-time)
				(apply #'encode-time (org-my-closing-time))))
		org-my-archive-expiry-days)
	    (org-archive-subtree))))
    (save-buffer)))

(defalias 'archive-done-tasks 'org-my-archive-done-tasks)

(defun org-get-inactive-time ()
  (let ((begin (point)))
    (save-excursion
      (outline-next-heading)
      (if (re-search-backward org-my-ts-regexp begin t)
	  (let ((time (float-time (org-time-string-to-time (match-string 0)))))
	    (assert (floatp time))
	    time)
	(debug)))))

(defun org-get-completed-time ()
  (let ((begin (point)))
    (save-excursion
      (outline-next-heading)
      (and (re-search-backward "\\(- State \"\\(DONE\\|DEFERRED\\|CANCELED\\)\"\\s-+\\[\\(.+?\\)\\]\\|CLOSED: \\[\\(.+?\\)\\]\\)" begin t)
	   (time-to-seconds (org-time-string-to-time (or (match-string 3)
							 (match-string 4))))))))

(defun org-my-sort-done-tasks ()
  (interactive)
  (goto-char (point-min))
  (org-sort-entries-or-items t ?F #'org-get-inactive-time #'<)
  (goto-char (point-min))
  (while (re-search-forward "


+" nil t)
    (delete-region (match-beginning 0) (match-end 0))
    (insert "
"))
  (let (after-save-hook)
    (save-buffer))
  (org-overview))

(defalias 'sort-done-tasks 'org-my-sort-done-tasks)

(defun jump-to-ledger-journal ()
  (interactive)
  (find-file-other-window "~/Dropbox/Accounts/ledger.dat")
  (goto-char (point-max))
  (insert (format-time-string "%Y/%m/%d ")))

(defun org-inline-note ()
  (interactive)
  (switch-to-buffer-other-window "todo.txt")
  (goto-char (point-min))
  (re-search-forward "^\\* Inbox$")
  (re-search-forward "^  :END:")
  (forward-line)
  (goto-char (line-beginning-position))
  (insert "** NOTE ")
  (save-excursion
    (insert (format "
   :PROPERTIES:
   :ID:       %s   :VISIBILITY: folded
   :END:
   " (shell-command-to-string "uuidgen")))
    (org-insert-time-stamp nil t 'inactive)
    (insert ?\n))
  (save-excursion
    (forward-line)
    (org-cycle)))

(defun org-get-message-link ()
  (let ((subject (do-applescript "tell application \"Mail\"
        set theMessages to selection
        subject of beginning of theMessages
end tell"))
        (message-id (do-applescript "tell application \"Mail\"
        set theMessages to selection
        message id of beginning of theMessages
end tell")))
    (org-make-link-string (concat "message://" message-id) subject)))

(defun org-get-message-sender ()
  (do-applescript "tell application \"Mail\"
        set theMessages to selection
        sender of beginning of theMessages
end tell"))

(defun org-get-url-link ()
  (let ((subject (do-applescript "tell application \"Safari\"
        name of document of front window
end tell"))
        (url (do-applescript "tell application \"Safari\"
        URL of document of front window
end tell")))
    (org-make-link-string url subject)))

(defun org-get-file-link ()
  (let ((subject (do-applescript "tell application \"Finder\"
	set theItems to the selection
	name of beginning of theItems
end tell"))
        (path (do-applescript "tell application \"Finder\"
	set theItems to the selection
	POSIX path of (beginning of theItems as text)
end tell")))
    (org-make-link-string (concat "file:" path) subject)))

(defun org-insert-message-link ()
  (interactive)
  (insert (org-get-message-link)))

(defun org-insert-url-link ()
  (interactive)
  (insert (org-get-url-link)))

(defun org-insert-file-link ()
  (interactive)
  (insert (org-get-file-link)))

(defun org-set-dtp-link ()
  "Set a property for the current headline."
  (interactive)
  (org-set-property "Document" (org-get-dtp-link)D))

(defun org-set-message-link ()
  "Set a property for the current headline."
  (interactive)
  (org-set-property "Message" (org-get-message-link)))

(defun org-set-message-sender ()
  "Set a property for the current headline."
  (interactive)
  (org-set-property "Submitter" (org-get-message-sender)))

(defun org-set-url-link ()
  "Set a property for the current headline."
  (interactive)
  (org-set-property "URL" (org-get-url-link)))

(defun org-set-file-link ()
  "Set a property for the current headline."
  (interactive)
  (org-set-property "File" (org-get-file-link)))

(defun org-dtp-message-open ()
  "Visit the message with the given MESSAGE-ID.
This will use the command `open' with the message URL."
  (interactive)
  (re-search-backward "\\[\\[message://\\(.+?\\)\\]\\[")
  (do-applescript
   (format "tell application \"DEVONthink Pro\"
	set searchResults to search \"%%3C%s%%3E\" within URLs
	open window for record (get beginning of searchResults)
end tell" (match-string 1))))

(defun org-export-tasks ()
  (interactive)
  (let ((index 1))
   (org-map-entries
    #'(lambda ()
	(outline-mark-subtree)
	(org-export-as-html 3)
	(write-file (format "%d.html" index))
	(kill-buffer (current-buffer))
	(setq index (1+ index)))
    "LEVEL=2")))

(defun org-make-regress-test ()
  (interactive)
  (save-excursion
    (outline-previous-visible-heading 1)
    (let ((begin (point))
	  (end (save-excursion
		 (outline-next-heading)
		 (point)))
	  (input "\n") (data "") (output ""))
      (goto-char begin)
      (when (re-search-forward ":SCRIPT:\n" end t)
	(goto-char (match-end 0))
	(let ((input-beg (point)))
	  (re-search-forward "[ 	]+:END:")
	  (setq input (buffer-substring input-beg (match-beginning 0)))))
      (goto-char begin)
      (when (search-forward ":\\(DATA\\|SOURCE\\):\n" end t)
	(goto-char (match-end 0))
	(let ((data-beg (point)))
	  (re-search-forward "[ 	]+:END:")
	  (setq data (buffer-substring data-beg (match-beginning 0)))))
      (goto-char begin)
      (when (search-forward ":OUTPUT:\n" end t)
	(goto-char (match-end 0))
	(let ((output-beg (point)))
	  (re-search-forward "[ 	]+:END:")
	  (setq output (buffer-substring output-beg (match-beginning 0)))))
      (goto-char begin)
      (when (re-search-forward ":ID:\\s-+\\([^-]+\\)" end t)
	(find-file (expand-file-name (concat (match-string 1) ".test")
				     "~/src/ledger/test/regress/"))
	(insert input "<<<\n" data ">>>1\n" output ">>>2\n=== 0\n")
	(pop-to-buffer (current-buffer))
	(goto-char (point-min))))))

(fset 'sort-todo-categories
   [?\C-u ?\C-s ?^ ?\\ ?* ?\S-  ?\C-a ?^ ?a ?^ ?p ?^ ?o ?\C-e])

(fset 'sort-subcategories
   [?\C-u ?\C-s ?^ ?\\ ?* ?\\ ?* ?\S-  ?P ?r ?o ?j ?e ?c ?t ?\C-a ?^ ?a ?^ ?p ?^ ?o ?\C-e])

(fset 'match-bug-list
   [?\C-s ?= ?\C-b ?\C-f ?\C-  ?\C-e ?\M-w ?\C-a ?\C-n C-return ?\M-< ?\C-s ?\M-y C-return])

(fset 'match-up-bugs
   [?\C-s ?= ?\C-  ?\C-e ?\M-w ?\C-a ?\C-n C-return ?\M-< ?\C-s ?# ?\M-y C-return])

(defun jump-to-org-agenda ()
  (interactive)
  (let ((buf (get-buffer "*Org Agenda*"))
	wind)
    (if buf
	(if (setq wind (get-buffer-window buf))
	    (select-window wind)
	  (if (called-interactively-p)
	      (progn
		(select-window (display-buffer buf t t))
		(org-fit-window-to-buffer)
		(org-agenda-redo)
		)
	    (with-selected-window (display-buffer buf)
	      (org-fit-window-to-buffer)
	      (org-agenda-redo)
	      )))
      (call-interactively 'org-agenda-list)))
  ;;(let ((buf (get-buffer "*Calendar*")))
  ;;  (unless (get-buffer-window buf)
  ;;    (org-agenda-goto-calendar)))
  )

(run-with-idle-timer 300 t 'jump-to-org-agenda)

;;;_* keybindings

;;;_ + global

(define-key global-map [(meta ?m)] 'org-capture)
(define-key global-map [(ctrl meta ?r)] 'org-capture)
(define-key global-map [(meta ?z)] 'org-inline-note)
(define-key global-map [(meta ?C)] 'jump-to-org-agenda)

(define-key mode-specific-map [?a] 'org-agenda)
(define-key mode-specific-map [(meta ?w)] 'org-store-link)
(define-key mode-specific-map [(shift ?w)] 'org-kill-entry)

(define-key mode-specific-map [?x ?d]
  #'(lambda nil (interactive) (org-todo "DONE")))
(define-key mode-specific-map [?x ?r]
  #'(lambda nil (interactive) (org-todo "DEFERRED")))
(define-key mode-specific-map [?x ?y]
  #'(lambda nil (interactive) (org-todo "SOMEDAY")))
(define-key mode-specific-map [?x ?g]
  #'(lambda nil (interactive) (org-todo "DELEGATED")))
(define-key mode-specific-map [?x ?n]
  #'(lambda nil (interactive) (org-todo "NOTE")))
(define-key mode-specific-map [?x ?s]
  #'(lambda nil (interactive) (org-todo "STARTED")))
(define-key mode-specific-map [?x ?t]
  #'(lambda nil (interactive) (org-todo "TODO")))
(define-key mode-specific-map [?x ?w]
  #'(lambda nil (interactive) (org-todo "WAITING")))
(define-key mode-specific-map [?x ?x]
  #'(lambda nil (interactive) (org-todo "CANCELED")))

(define-key mode-specific-map [?x ?L] 'org-set-dtp-link)
(define-key mode-specific-map [?x ?M] 'org-set-message-link)
(define-key mode-specific-map [?x ?Y] 'org-set-message-sender)
(define-key mode-specific-map [?x ?U] 'org-set-url-link)
(define-key mode-specific-map [?x ?F] 'org-set-file-link)
(define-key mode-specific-map [?x ?C] 'cvs-examine)
(define-key mode-specific-map [?x ?S] 'svn-status)
(define-key mode-specific-map [?x ?b] 'org-insert-bug)
(define-key mode-specific-map [?x ?l] 'org-insert-dtp-link)
(define-key mode-specific-map [?x ?m] 'org-insert-message-link)
(define-key mode-specific-map [?x ?u] 'org-insert-url-link)
(define-key mode-specific-map [?x ?f] 'org-insert-file-link)

(defun org-trac-ticket-open ()
  (interactive)
  (browse-url (concat "http://trac.newartisans.com/ledger/ticket/"
		      (org-entry-get (point) "Ticket"))))

(define-key mode-specific-map [?x ?T] 'org-trac-ticket-open)

(define-key mode-specific-map [(shift ?y)] 'org-yank-entry)

;;;_ + org-mode

(eval-after-load "org"
  '(progn
     (require 'yasnippet)
     (org-defkey org-mode-map [(control meta return)] 'org-insert-heading-after-current)
     (org-defkey org-mode-map [(control return)] 'other-window)
     (define-key org-mode-map [return] 'org-return-indent)

     (defun org-fit-agenda-window ()
       "Fit the window to the buffer size."
       (and (memq org-agenda-window-setup '(reorganize-frame))
	    (fboundp 'fit-window-to-buffer)
	    (fit-window-to-buffer)))

     (defun yas/org-very-safe-expand ()
       (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

     (autoload 'yas/expand "yasnippet" "Expand a snippet before point.

If no snippet expansion is possible, fall back to the behaviour
defined in `yas/fallback-behavior'" t)

     (add-hook 'org-mode-hook
	       (lambda ()
		 ;; yasnippet (using the new org-cycle hooks)
		 (make-variable-buffer-local 'yas/trigger-key)
		 (setq yas/trigger-key [tab])
		 (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
		 (define-key yas/keymap [tab] 'yas/next-field)))))

(defun org-agenda-reschedule-to-today ()
   (interactive)
   (flet ((org-read-date (&rest rest) (current-time)))
     (call-interactively 'org-agenda-schedule))
   )    
    
    
(eval-after-load "org-agenda"    
  '(progn    
     (dolist (map (list org-agenda-keymap org-agenda-mode-map))    
       (define-key map "\C-n" 'next-line)
       (define-key map "\C-p" 'previous-line)

       (define-key map "g" 'org-agenda-redo)
       (define-key map "r"
	 #'(lambda nil
	     (interactive)
	     (error "The 'r' command is deprecated here; use 'g'")))
       (define-key map "f" 'org-agenda-date-later)
       (define-key map "b" 'org-agenda-date-earlier)
       (define-key map "r" 'org-agenda-refile)
       (define-key map " " 'org-agenda-tree-to-indirect-buffer)
       (define-key map "F" 'org-agenda-follow-mode)
       (define-key map "q" 'delete-window)
       (define-key map [(meta ?.)] 'org-agenda-reschedule-to-today)
       (define-key map [(meta ?p)] 'org-agenda-earlier)
       (define-key map [(meta ?n)] 'org-agenda-later)

       (define-prefix-command 'org-todo-state-map)

       (define-key map "x" 'org-todo-state-map)

       (define-key map "\C-c\C-s" 'org-agenda-sunrise-sunset)
       (define-key map "S" 'org-agenda-schedule)

       (defun org-todo-mark-done ()
         (interactive) (org-agenda-todo "DONE"))
       (defun org-todo-mark-deferred ()
         (interactive) (org-agenda-todo "DEFERRED"))
       (defun org-todo-mark-someday ()
         (interactive) (org-agenda-todo "SOMEDAY"))
       (defun org-todo-mark-delegated ()
         (interactive) (org-agenda-todo "DELEGATED"))
       (defun org-todo-mark-note ()
         (interactive) (org-agenda-todo "NOTE"))
       (defun org-todo-mark-started ()
         (interactive) (org-agenda-todo "STARTED"))
       (defun org-todo-mark-todo ()
         (interactive) (org-agenda-todo "TODO"))
       (defun org-todo-mark-waiting ()
         (interactive) (org-agenda-todo "WAITING"))
       (defun org-todo-mark-canceled ()
         (interactive) (org-agenda-todo "CANCELED"))

       (define-key org-todo-state-map "d" #'org-todo-mark-done)
       (define-key org-todo-state-map "r" #'org-todo-mark-deferred)
       (define-key org-todo-state-map "y" #'org-todo-mark-someday)
       (define-key org-todo-state-map "g" #'org-todo-mark-delegated)
       (define-key org-todo-state-map "n" #'org-todo-mark-note)
       (define-key org-todo-state-map "s" #'org-todo-mark-started)
       (define-key org-todo-state-map "t" #'org-todo-mark-todo)
       (define-key org-todo-state-map "w" #'org-todo-mark-waiting)
       (define-key org-todo-state-map "x" #'org-todo-mark-canceled)

       (define-key org-todo-state-map "z" #'make-bug-link))))


;;;_* startup

(add-hook 'after-init-hook
	  (function
	   (lambda ()
	     (org-agenda-list)
	     (org-resolve-clocks))))

