;; Make sure my locally-installed packages have available info in the tree
(defun find-subdirs-containing-info (dir)
  ;; Note: looking for "dir" is really a hack to get around the fact
  ;; that some packages don't install their info with a .info
  ;; extension.  I'm not sure what the best non-hack would be.
  (find-subdirs-containing dir "\\.info\\|\\`dir\\'"))

(defun add-init-path-to-info-path ()
  "Add the subdirectories of init-path that contain info directory
files to the Info-directory-list.  This can safely be run many times
in a session, without adding multiple copies of the directories.  The
new directories are prepended to emacs's initial Info path."
  (interactive)
  (setq Info-directory-list
        (append 
         (find-subdirs-containing-info init-path)
         (find-subdirs-containing-info init-3rd-party-path) 
         initial-info-path)))

(defun add-info-dir-files-to-path (tree)
  "Add all the info files under TREE to info \"dir\" files"
  (let ((info-dirs (find-subdirs-containing-info tree)))
    (mapcar (lambda (dir)
	      (dolist (file (directory-files dir t "\\.info\\'"))
                (let ((dir-file (format "%s/dir" dir)))
                  (if 
                      (or (not (file-exists-p dir-file))
                          (file-newer-than-file-p file dir-file))
                      (call-process "install-info" nil (get-buffer "*Messages*") nil
                                    (format "--dir-file=%s" dir-file) file
                                    )))))
	    info-dirs)))

;;; Create dir files for any info files in the init-path
(add-info-dir-files-to-path init-path)
(add-info-dir-files-to-path init-3rd-party-path)

;;; Add the init-path tree to the Info path
(require 'info)
(info-initialize)
(setq initial-info-path Info-directory-list)
(add-init-path-to-info-path)
