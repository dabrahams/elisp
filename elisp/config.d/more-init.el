;; Load environment variables and set up PATH from ~/.MacOSX/environment.plist
;; 
;; It was my understanding that it was supposed to happen
;; automatically, but this works, at least.
(if (eq system-type 'darwin)
    ;; This is not important enough to abort startup on failure
    (ignore-errors
      (require 'osx-plist)
      (osx-plist-update-environment)))

;; Maximize emacs on startup
(ignore-errors
  (require 'maxframe)
  (if (eq system-type 'gnu/linux)
   (setq mf-max-width 1600))  ;; Pixel width of main monitor.
  (add-hook 'window-setup-hook 'maximize-frame t))

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

;; Python egg files are really .zip archives
(setq auto-mode-alist
      (cons '("\\.egg\\'" . archive-mode) auto-mode-alist))

;; Markdown has no official file extension, but I'll use this
(setq auto-mode-alist
      (cons '("\\.text\\'" . markdown-mode) auto-mode-alist))

;; Create the auto-save directory if it doesn't exist.  See
;; customization of variable: auto-save-file-name-transforms
(make-directory "~/.emacs.d/auto-saves" t)

;; What the heck, I like it.
(ido-mode)

(defun my-text-mode-smart-keys ()
  (when (fboundp 'unicode-smart-double-quote)
    (unless (or (equal (char-syntax ?\") ?\") (equal (char-syntax ?\') ?\"))
      (require 'my-xmlunicode) ; This helps avoid an annoying delay at the first quote key
;      (local-set-key [?\-] 'unicode-smart-hyphen)
;      (local-set-key [?\.] 'unicode-smart-period)
      (local-set-key (kbd "C-\"") 'unicode-smart-double-quote)
      (local-set-key (kbd "C-'") 'unicode-smart-single-quote))))

(add-hook 'after-change-major-mode-hook 'my-text-mode-smart-keys)
