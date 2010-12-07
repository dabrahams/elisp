;; Snarfed from PierreJeanTurpeau at
;; http://www.emacswiki.org/emacs/AutoRecompile
;;
;; He writes: 
;;
;;   this one tries to be less distracting by pre-splitting
;;   the window with a smaller *Compile-Log* buffer, auto-scroll to the
;;   last line to quickly show a potential error and then auto-close the
;;   *Compile-Log* window. It would be better to have a real error
;;   detection with a notification message rather than a dumb
;;   auto-scroll. Next time perhaps.
;;
;; I've modified it a bit to make it more resilient to window height
;; restrictions.
(require 'cl)

(defun pj/auto-recompile-file-always ()
  (interactive)
  (when (equal mode-name "Emacs-Lisp")
    (let ((maximum-compile-log-height 8)
          (old-window-start (window-start))
          (old-window-point (window-point))
          (buf (get-buffer-create "*Compile-Log*"))
          )

      ;; temporarily override minimum window height; split if there's
      ;; any way we can do it.
      (letf ((window-min-height 1))
        ;; Attempt to pre-split for compile log buffer so that it does
        ;; not modify the layout.  If there is not even enough space for
        ;; a window split of height 1, just itnore the error and don't
        ;; split.
        (ignore-errors
          (set-window-buffer 
           (split-window-vertically 
            (max 1 (/ (window-height) 2) (- (window-height) maximum-compile-log-height)))
           buf)
         )

        ;; byte compile the buffer
        (byte-compile-file buffer-file-name)
        ;; scroll to the end to see if there's an error
        (set-window-point (get-buffer-window buf) (buffer-size buf))
        ;; auto close the compile log window and restore original display position
        (run-at-time 1.0 nil (lambda (buf)
                               (delete-windows-on buf)
                               (set-window-point (selected-window) old-window-point)
                               (set-window-start (selected-window) old-window-start))
                     buf)))))

;;(add-hook 'emacs-lisp-mode-hook
;;          (lambda () (add-hook 'after-save-hook 'pj/auto-recompile-file-always nil t)))

