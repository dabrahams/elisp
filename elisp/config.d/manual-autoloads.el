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

