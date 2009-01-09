;; Maximize emacs on startup
(and nil (ignore-errors
  (require 'maxframe)
  (setq mf-max-width 1600)  ;; Pixel width of main monitor.
  (add-hook 'window-setup-hook 'maximize-frame t)))

;; turn off the nasty system bell
(setq ring-bell-function (lambda ()))

(defadvice split-window (before by-default-split-horizontally activate)
  "When the system is going to split the window and we have lots
of horizontal space, I want to split it horizontally!  The
default of splitting vertically (i.e. with a horizontal divider)
leaves me looking at really long lines through really narrow
spaces, which kinda blows."
  (if (and (not (ad-get-arg 2)) (> (window-width (or (ad-get-arg 0) (selected-window)) 160)))
      (ad-set-arg 2 t)))
