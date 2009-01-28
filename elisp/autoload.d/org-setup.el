(add-hook 'org-mode-hook
 (lambda ()
  (local-set-key [(control ?,)] 'backward-word)
  ))
