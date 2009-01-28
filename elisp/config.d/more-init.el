;; Maximize emacs on startup
(and nil (ignore-errors
  (require 'maxframe)
  (setq mf-max-width 1600)  ;; Pixel width of main monitor.
  (add-hook 'window-setup-hook 'maximize-frame t)))

;; This is probably not the best way to do it, but...
;; 
;; The planner-el package contains a contrib/ directory with a version
;; of timetrack.el that only likes Xemacs.  To avoid loading it, we
;; sort that package to the back of the load path.
(sort load-path 
      (lambda (x y) 
        (let ((contrib 
               (expand-file-name "~/elisp/package.d/planner-el/contrib")))
          (and (not (string-equal x y)) (string-equal y contrib)))))

;; turn off the nasty system bell
(setq ring-bell-function (lambda ()))

<<<<<<< HEAD:elisp/config.d/more-init.el
;; Python egg files are really .zip archives
(setq auto-mode-alist
      (cons '("\\.egg\\'" . archive-mode) auto-mode-alist))
=======
;; Create the auto-save directory if it doesn't exist.  See
;; customization of variable: auto-save-file-name-transforms
(make-directory "~/.emacs.d/auto-saves" t)

>>>>>>> dd4a6fa388fbcb2bdab6fcda14288444fc252ef4:elisp/config.d/more-init.el
