(defun my-svn-status-parse-fixup-tramp-exit ()
  "Helper function to handle tramp connections stopping with an exit output.
Add this function to the `svn-pre-parse-status-hook'."
  (goto-char (point-max))
  (when (looking-back "^\\(?:exit[^\n]*\\|Tramp connection closed\\)\n?" nil t)
    (delete-region (match-beginning 0) (point-max))
    (when (looking-back "^logout\n") (delete-region (match-beginning 0) (point-max)))
  ))
(add-hook 'svn-pre-parse-status-hook 'my-svn-status-parse-fixup-tramp-exit)
