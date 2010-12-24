(custom-set-variables
 '(ns-alternate-modifier 'control)
 '(ns-control-modifier 'control)
 '(ns-command-modifier 'meta))

(split-window-horizontally)

(dolist (f 
         '("/Users/dave/Dropbox/src/elhome/example/init.d/00-essentials.el" 
           "/Users/dave/src/elisp.repo/elisp/package.d/initsplit.el"
           "/tmp/test-initsplit/org-cust.el"
           ))
  (load f) 
  (switch-to-buffer (find-file-other-window f)))
