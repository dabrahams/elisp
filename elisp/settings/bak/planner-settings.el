(setq planner-project "WikiPlanner")
(setq muse-project-alist
      '(("WikiPlanner"
	 ("~/plans"   ;; Or wherever you want your planner files to be
	  :default "index"
	  :major-mode planner-mode
	  :visit-link planner-visit-link))))
(require 'planner)
(require 'w3m)
(require 'planner-w3m)

(global-set-key [(f9)] nil)
(global-set-key [(f9) (t)] 'planner-create-task-from-buffer)
(global-set-key [(f9) (r)] 'remember)

(require 'remember-planner)
(setq remember-annotation-functions planner-annotation-functions)
(setq remember-handler-functions '(remember-planner-append))
(setq remember-append-to-planner-hook
      '(remember-planner-add-timestamp))