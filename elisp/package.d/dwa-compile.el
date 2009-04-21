;; Used by my-compile and my-recompile to get back to the bottom of a
;; compilation buffer after save-excursion brings us back to the place we
;; started.
(defun my-end-of-current-compilation-buffer()
  (if (equal (buffer-name) "*compilation*")
      (end-of-buffer)))
  
;;;###autoload
(defun my-compile(&optional command)
  (interactive)
  (if (interactive-p)
      (call-interactively 'compile)
    (compile command))
  (save-excursion
    (pop-to-buffer "*compilation*")
    (end-of-buffer))
  ;; force scrolling despite save-excursion
  (my-end-of-current-compilation-buffer))

(defun my-buffer-exists (buffer)
  "Return t if the buffer exists.
buffer is either a buffer object or a buffer name"
  (bufferp (get-buffer buffer)))
  
;;;###autoload
(defun my-recompile ()
  "Run recompilation but put the point at the *end* of the buffer
so we can watch errors as they come up"
  (interactive)
  (if (and (my-buffer-exists "*compilation*")
           compile-command)
      (save-excursion
        ;; switching to the compilation buffer here causes the compile command to be
        ;; executed from the same directory it originated from.
        (pop-to-buffer "*compilation*")
        (recompile)
        (pop-to-buffer "*compilation*")
        (end-of-buffer))
    ;; else
    (call-interactively 'my-compile))
  ;; force scrolling despite save-excursion
  (my-end-of-current-compilation-buffer))

