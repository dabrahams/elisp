;; Make sure my locally-installed packages have available info in the tree
(defun find-subdirs-containing-info (dir)
  (find-subdirs-containing dir "\\.info\\'"))

(defun add-init-path-to-info-path ()
  "Add the subdirectories of init-path that contain info directory
files to the Info-directory-list.  This can safely be run many times
in a session, without adding multiple copies of the directories.  The
new directories are prepended to emacs's initial Info path."
  (interactive)
  (setq Info-directory-list
        (append (find-subdirs-containing-info init-path) initial-info-path)))

;;; Make sure we have /sbin in the path - SUSE puts install-info there
(add-to-list 'exec-path "/sbin")

(defun add-info-dir-files-to-path (tree)
  "Add all the info files under TREE to info \"dir\" files"
  (let ((info-dirs (find-subdirs-containing-info tree)))
    (mapcar (lambda (dir)
	      (dolist (file (directory-files dir t "\\.info\\'"))
		(call-process "install-info" nil t nil
			      (format "--infodir=%s" dir) file
                              )))
	    info-dirs)))

;;; Create dir files for any info files in the init-path
(add-info-dir-files-to-path init-path)

;;; Add the init-path tree to the Info path
(require 'info)
(info-initialize)
(setq initial-info-path Info-directory-list)
(add-init-path-to-info-path)
