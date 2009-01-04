(provide 'code-settings)
(defun my-code-mode-hook ()
  (font-lock-mode t)
  (show-paren-mode t)
  (local-set-key [return] 'newline-and-indent)
  (local-set-key [(control return)] 'newline)
  (local-set-key [( control ?\( )] 'my-matching-paren)
  
  ;; Try to make completion case sensitive in code buffers.
  (make-local-variable 'dabbrev-case-fold-search)
  (setq dabbrev-case-fold-search nil)
  )
