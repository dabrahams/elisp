(provide 'config-w32)

(when (eq system-type 'windows-nt)
  (setq w32-enable-italics t)
  (setq w32-enable-synthesized-fonts t)

    ;; Hook the directory-files function.
  
  (defadvice directory-files (after my-directory-files-advice activate compile)
    "downcases the filenames that result from the builtin directory-files function"
    (setq ad-return-value (mapcar 'downcase ad-return-value)))

;;       (defadvice ediff-files3 (before my-ediff3-forward-slashes activate)
;;         (ad-set-arg 0 (my-forward-slashes (ad-get-arg 0)) t)
;;         (ad-set-arg 1 (my-forward-slashes (ad-get-arg 1)) t)
;;         (ad-set-arg 2 (my-forward-slashes (ad-get-arg 2)) t)
;;         )
      
;;       (defadvice ediff-temp-file (after my-ediff-temp-file-forward-slashes activate compile)
;;         (setq ad-return-value (my-forward-slashes ad-return-value))
;;         )
      
  (defun w32-restore-frame ()
    "Restore a minimized frame"
    (interactive)
    (w32-send-sys-command 61728))

  (defun w32-maximize-frame ()
    "Maximize the current frame"
    (interactive)
    (w32-send-sys-command 61488))

  (when (boundp 'w32-send-sys-command)
      (w32-maximize-frame))

  )