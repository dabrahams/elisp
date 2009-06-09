;;
;; General utilities
;;

(defun my-kill-buffer ()
  "Just kill the current buffer without asking, unless of course it's a
modified file"
  (interactive)
  (kill-buffer (current-buffer)))

(defun my-switch-to-previous-buffer ()
  "Switch to the most recently visited buffer without asking"
  (interactive)
  (switch-to-buffer nil))

(defun my-info-other-frame ()
  (interactive)
  (select-frame (make-frame))
  (info))

(defun my-mark-or-point ()
  "Return the mark if it is active, otherwise the point."
  (if
      (if (fboundp 'region-active-p) (region-active-p) mark-active)
      (mark)
    (point)))

(defun my-selection ()
  "Return a pair [start . finish) delimiting the current selection"
      (let ((start (make-marker))
            (finish (make-marker)))
        (set-marker start (min (my-mark-or-point) (point)))

        (set-marker finish (max (my-mark-or-point) (point)))
        (cons start finish)))

(defun my-replace-in-region (start finish key replacement)
  "In the range [START, FINISH), replace text matching KEY with REPLACEMENT"
  (goto-char start)
  (while (search-forward key finish t)
    (replace-match replacement)))

(defun my-activate-mark ()
  "Make the mark active if it is currently inactive"
  (set-mark (mark t)))


(defun my-matching-paren (arg)
  (interactive "P")
  (if arg
      () ;;(insert "%")  ; insert the character we're bound to
    (cond ((looking-at "[[({]")
           (forward-sexp 1)
           (forward-char -1))
          ((looking-at "[]})]")
           (forward-char 1)
           (forward-sexp -1))
          (t
           ;; (insert "%")  ; insert the character we're bound to
      ))))

; Something for converting DOS files to unix format
(defun my-use-code-undecided-unix ()
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix)
  (save-buffer))

(defun my-other-window-backward (&optional n)
  "Select the previous window. Copied from \"Writing Gnu Emacs Extensions\"."
  (interactive "P")
  (other-window (- (or n 1)))
  )

; return the first non-nil result of applying f to each element of seq
(defun my-first-non-nil (seq f)
  (and seq
       (or
        (apply f (list (car seq)))
        (my-first-non-nil (cdr seq) f)))
  )

(defun my-mode-read ()
  (let ((symb 'c++-mode)
	(predicate 'commandp)
	(enable-recursive-minibuffers t)
	val)
    (setq val (completing-read
	       (concat "Mode "
		       (if symb
			   (format " (default %s)" symb))
		       ": ")
	       obarray predicate t nil))
    (list (if (equal val "")
	      symb
	    (intern val)))))

(defun my-clone-region-set-mode (&optional mode)
  (interactive (my-mode-read))
  (let ((pt (point))(mk (my-mark-or-point)))
    (with-current-buffer (clone-indirect-buffer-other-window "*clone*" t)
    (narrow-to-region pt mk)
    (if mode
	(funcall mode)
      (lisp-mode)))))

(provide 'dwa-util)