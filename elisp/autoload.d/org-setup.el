(add-hook 'org-mode-hook
;; org mode overrides my standard meaning for `C-,' by default.  Get it back.
 (lambda ()
  (local-set-key [(control ?,)] 'backward-word)
  ))

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)
     (define-key org-mode-map "\C-cx" 'org-todo-state-map)
))

;(require 'remember)
;(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map [(control meta ?r)] 'remember)
