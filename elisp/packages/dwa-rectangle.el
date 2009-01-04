;; Emacs has a bunch of built-in commands for working with rectangular regions
;; of the screen (try "M-x apropos RET rectangle" for a list). These can be
;; *really cool* for making diagrams in text. There a couple of really useful
;; things missing from the built-in rectangle support, though, especially if
;; you're making pictures. First, the built-in yank-rectangle moves text which
;; is to the right of point over to avoid the new text. Sometimes you just want
;; that, but other times you just want to drop in a yanked rectangle on top of
;; what's there without disturbing the rest of the picture. That's what
;; my-yank-replace-rectangle does. Also, there's no built-in way of copying a
;; region to the rectangle kill-buffer. For that, we have my-save-rectangle.
(defun my-yank-replace-rectangle ()
  "Replace a rectangular region with the last killed rectangle, placing its upper left corner at point."
  (interactive)
  (my-replace-rectangle killed-rectangle))

(defun my-replace-rectangle (rectangle)
  "Replace rectangular region with RECTANGLE, placing its upper left corner at point.
RECTANGLE's first line is inserted at point, its second
line is inserted at a point vertically under point, etc.
RECTANGLE should be a list of strings.
After this command, the mark is at the upper left corner
and point is at the lower right corner."
  (let (
        (lines rectangle)
        (insertcolumn (current-column))
        (save-overwrite-mode overwrite-mode)
        (width (length (car rectangle)))
        (endcolumn (+ (current-column) (length (car rectangle))))
        (first t))
    (push-mark)
    (setq overwrite-mode nil)
    (while lines
      (or first
          (progn
            (forward-line 1)
            (or (bolp) (insert ?\n))))
      (move-to-column-force endcolumn)
      (delete-backward-char width)
      (setq first nil)
      (insert (car lines))
      (setq lines (cdr lines)))
    (setq overwrite-mode save-overwrite-mode)
    ))

(defun my-save-rectangle (start end)
  "Save rectangle with corners at point and mark as last killed one.
Calling from program, supply two args START and END, buffer positions."
  (interactive "r")
  (setq killed-rectangle (extract-rectangle start end)))

(defun my-kill-rectangle (start end)
  "Save rectangle with corners at point and mark as last killed one,
and erase it.  Calling from program, supply two args START and END,
buffer positions."
  (interactive "r")
  (my-save-rectangle start end)
  (clear-rectangle start end))

(provide 'dwa-rectangle)
