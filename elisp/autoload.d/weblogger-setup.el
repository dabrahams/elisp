(defun my-weblogger-save ()
  (interactive)
  (if (string= mode-name "Weblog")
      (weblogger-save-entry)
    (save-excursion
      (weblogger-toggle-edit-body)
      (weblogger-save-entry)
      (weblogger-toggle-edit-body)
      )))

(defun my-weblogger-markdown-mode ()
  (interactive)
  (markdown-mode)
  (local-set-key "\C-x\C-s" 'my-weblogger-save))

(define-key weblogger-entry-mode-map "\C-x\C-s" 'weblogger-save-entry)

