;; Maximize emacs on startup
; (require 'cl)

(and nil (ignore-errors
  (require 'maxframe)
  (setq mf-max-width 1600)  ;; Pixel width of main monitor.
  (add-hook 'window-setup-hook 'maximize-frame t)))

;; turn off the nasty system bell
(setq ring-bell-function (lambda ()))
