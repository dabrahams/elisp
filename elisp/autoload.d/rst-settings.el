   (autoload 'rst-mode "rst" "mode for editing reStructuredText documents" t)
   (setq auto-mode-alist
         (append '(("\\.rst$" . rst-mode)
                   ("\\.rest$" . rst-mode)) auto-mode-alist))
