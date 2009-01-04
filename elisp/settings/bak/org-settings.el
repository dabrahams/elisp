(ignore-errors (require 'org))

(defun my-org-mode-hook ()
  (local-set-key [(control ?c) (n)] 'org-cycle-agenda-files)
  (local-set-key [(control ?,)] 'backward-word)
  (auto-fill-mode)
  )

(add-hook 'org-mode-hook 'my-org-mode-hook)

;; URL dragging support; see http://www.emacswiki.org/emacs/OrgMode
(defadvice dnd-insert-text (around org-mouse-dnd-insert-text activate)
  (if (eq major-mode 'org-mode)
      (progn
	(cond
	 ;; if this is the end of the line then just insert text here
	 ((eolp)
	  (skip-chars-backward " \t") 
	  (kill-region (point) (point-at-eol))
	  (unless (looking-back ":") (insert ":"))
	  (insert " "))
	 
	 ;; if this is the beginning of the line then insert before 
	 ((and (looking-at " \\|\t")	
	       (save-excursion
		 (skip-chars-backward " \t") (bolp)))
	  (beginning-of-line) 
	  (looking-at "[ \t]*")
	  (open-line 1)
	  (indent-to (- (match-end 0) (match-beginning 0)))
	  (insert "+ "))
	 
	 ;; if this is a middle of the line, then insert after
	 (t 
	  (end-of-line) 
	  (newline t) 
	  (indent-relative)
	  (insert "+ ")))
	(insert text)
	(beginning-of-line))
    ad-do-it))


;;(require 'remember-autoloads)
   (setq org-remember-templates
      '(("Tasks" ?t "* TODO %?\n  %i\n  %a" "~/organizer.org")                      ;; (2)
        ("Appointments" ?a "* Appointment: %?\n%^T\n%i\n  %a" "~/organizer.org")))
   (setq remember-annotation-functions '(org-remember-annotation))
   (setq remember-handler-functions '(org-remember-handler))
   (eval-after-load 'remember
     '(add-hook 'remember-mode-hook 'org-remember-apply-template))
   (global-set-key (kbd "C-c r") 'remember)                                         ;; (3)

   (require 'org)
   ;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))                           ;; (4)
   (global-set-key (kbd "C-c a") 'org-agenda)                                       ;; (5)
   (setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE"))                    ;; (6)
   (setq org-agenda-include-diary t)                                                ;; (7)
   (setq org-agenda-include-all-todo t)                                             ;; (8)

   (setq org-hide-leading-stars t)
