;;; my-loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (any-ini-mode) "any-ini-mode" "../../../../elisp/package.d/any-ini-mode.el"
;;;;;;  (18847 2295))
;;; Generated autoloads from ../../../../elisp/package.d/any-ini-mode.el

(autoload 'any-ini-mode "any-ini-mode" "\
*Major mode for editing config files with syntax highlighting based on a 'source of truth'.

You may set up a default style for all <any>.ini mode buffers, or, more usefully,
you may set up several styles that will be automatically applied based on the name
of the file being visited.

See `any-ini-set-my-style' and `any-ini-styles-alist' for more details.

Turning on <any>.ini mode runs the normal hook `any-ini-mode-hook'.

\(fn)" t nil)

;;;***

;;;### (autoloads (my-recompile my-compile) "dwa-compile" "../../../../elisp/package.d/dwa-compile.el"
;;;;;;  (18915 22968))
;;; Generated autoloads from ../../../../elisp/package.d/dwa-compile.el

(autoload 'my-compile "dwa-compile" "\
Not documented

\(fn &optional COMMAND)" t nil)

(autoload 'my-recompile "dwa-compile" "\
Run recompilation but put the point at the *end* of the buffer
so we can watch errors as they come up

\(fn)" t nil)

;;;***

;;;### (autoloads (git-reblame git-blame-mode) "git-blame" "../../../../elisp/package.d/git-contrib/git-blame.el"
;;;;;;  (18853 51588))
;;; Generated autoloads from ../../../../elisp/package.d/git-contrib/git-blame.el

(autoload 'git-blame-mode "git-blame" "\
Toggle minor mode for displaying Git blame

With prefix ARG, turn the mode on if ARG is positive.

\(fn &optional ARG)" t nil)

(autoload 'git-reblame "git-blame" "\
Recalculate all blame information in the current buffer

\(fn)" t nil)

;;;***

;;;### (autoloads (svn-status svn-checkout) "psvn" "../../../../elisp/package.d/psvn.el"
;;;;;;  (18917 64142))
;;; Generated autoloads from ../../../../elisp/package.d/psvn.el

(autoload 'svn-checkout "psvn" "\
Run svn checkout REPOS-URL PATH.

\(fn REPOS-URL PATH)" t nil)
 (defalias 'svn-examine 'svn-status)

(autoload 'svn-status "psvn" "\
Examine the status of Subversion working copy in directory DIR.
If ARG is -, allow editing of the parameters. One could add -N to
run svn status non recursively to make it faster.
For every other non nil ARG pass the -u argument to `svn status', which
asks svn to connect to the repository and check to see if there are updates
there.

If there is no .svn directory, examine if there is CVS and run
`cvs-examine'. Otherwise ask if to run `dired'.

\(fn DIR &optional ARG)" t nil)

;;;***

;;;### (autoloads (rst-minor-mode rst-mode) "rst" "../../../../elisp/package.d/rst.el"
;;;;;;  (18846 37975))
;;; Generated autoloads from ../../../../elisp/package.d/rst.el

(autoload 'rst-mode "rst" "\
Not documented

\(fn)" t nil)

(autoload 'rst-minor-mode "rst" "\
ReST Minor Mode.
Toggle ReST minor mode.
With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode.

When ReST minor mode is enabled, the ReST mode
keybindings are installed on top of the major
mode bindings. Use this for modes derived from
text-mode, like mail-mode..

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../elisp/package.d/any-ini-mode.el"
;;;;;;  "../../../../elisp/package.d/dwa-c++.el" "../../../../elisp/package.d/dwa-compile.el"
;;;;;;  "../../../../elisp/package.d/dwa-rectangle.el" "../../../../elisp/package.d/dwa-util.el"
;;;;;;  "../../../../elisp/package.d/git-contrib/git-blame.el" "../../../../elisp/package.d/git-contrib/git.el"
;;;;;;  "../../../../elisp/package.d/gravatar.el" "../../../../elisp/package.d/initsplit.el"
;;;;;;  "../../../../elisp/package.d/maxframe.el" "../../../../elisp/package.d/osx-plist.el"
;;;;;;  "../../../../elisp/package.d/psvn.el" "../../../../elisp/package.d/rst.el"
;;;;;;  "../../../../elisp/package.d/timeclock-x.el") (18927 20761
;;;;;;  319914))

;;;***

(provide 'my-loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; my-loaddefs.el ends here
