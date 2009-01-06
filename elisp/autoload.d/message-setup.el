(defun my-message-insert-citation-line ()
  "Insert a simple citation line that slightly obscures the email address of the sender."

  (when message-reply-headers
    (insert "\non " 
            (format-time-string 
             "%a %b %d %Y" (date-to-time (mail-header-date message-reply-headers))) 
            ", "
            (replace-regexp-in-string "@" "-AT-" (mail-header-from message-reply-headers))
            " wrote:\n\n"))
)

