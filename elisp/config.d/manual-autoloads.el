;; This file contains autoloads that perhaps ought to have been
;; embedded in packages I'm using, but weren't.

(autoload 'magit-status "magit"
  "magit package supplies no doc." t)

(autoload 'cmake-mode "cmake-mode"
  "Major mode for editing CMake listfiles." t)

(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(autoload 'jam-mode "jam-mode"
  "no doc provided." t)

(setq auto-mode-alist
	  (append
	   '(("`Jamfile\\(\\.v2\\)'" . jam-mode))
	   '(("`Jamroot'" . jam-mode))
	   '(("\\.jam\\'" . jam-mode))
	   auto-mode-alist))


