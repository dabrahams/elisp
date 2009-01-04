(require 'cl)
(ignore-errors
    (require 'psvn))

(setq-default 
 svn-status-track-user-input t
 svn-status-custom-hide-function 'my-svn-status-hide-pyc-files
)

(defun my-svn-status-hide-pyc-files (info)
  "Hide all pyc files in the `svn-status-buffer-name' buffer."
   (let* ((fname (svn-status-line-info->filename-nondirectory info))
          (fname-len (length fname)))
     (and (> fname-len 4) (string= (substring fname (- fname-len 4)) ".pyc"))))
