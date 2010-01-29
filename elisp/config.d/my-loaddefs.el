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

;;;### (autoloads (kill-buffer-and-its-windows read-shell-file-command
;;;;;;  region-to-file region-to-buffer forward-char-same-line) "misc-cmds"
;;;;;;  "../../../../elisp/package.d/misc-cmds.el" (19271 40288))
;;; Generated autoloads from ../../../../elisp/package.d/misc-cmds.el

(autoload 'forward-char-same-line "misc-cmds" "\
Move forward a max of ARG chars on the same line, or backward if ARG < 0.
Returns the signed number of chars moved if /= ARG, else returns nil.

\(fn &optional ARG)" t nil)

(autoload 'region-to-buffer "misc-cmds" "\
Copy region to BUFFER: At beginning (prefix >= 0), end (< 0), or replace.
START and END are the region boundaries.
BUFFER is a buffer or its name (a string).
With prefix ARG >= 0: `append-to-buffer':
  Append contents of region to end of BUFFER.
  (Point is moved to end of BUFFER first.)
With prefix ARG < 0:  `prepend-to-buffer':
  Prepend contents of region to beginning of BUFFER.
  (Point is moved to beginning of BUFFER first.)
With no prefix ARG (nil): `copy-to-buffer'.
  Write region to BUFFER, replacing any previous contents.

\(fn START END BUFFER ARG)" t nil)

(autoload 'region-to-file "misc-cmds" "\
With prefix arg, this is `append-to-file'.  Without, it is `write-region'.
START and END are the region boundaries.
Prefix ARG non-nil means append region to end of file FILENAME.
Prefix ARG nil means write region to FILENAME, replacing contents.

\(fn START END FILENAME ARG)" t nil)

(autoload 'read-shell-file-command "misc-cmds" "\
Prompt for shell COMMAND, using current buffer's file as default arg.
If buffer is not associated with a file, you are prompted for a file.
COMMAND is a symbol.

\(fn COMMAND)" nil nil)

(autoload 'kill-buffer-and-its-windows "misc-cmds" "\
Kill BUFFER and delete its windows.  Default is `current-buffer'.
BUFFER may be either a buffer or its name (a string).

\(fn BUFFER)" t nil)

;;;***

;;;### (autoloads (svn-status svn-checkout) "psvn" "../../../../elisp/package.d/psvn.el"
;;;;;;  (18928 54753))
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

;;;### (autoloads (weblogger-fetch-entries weblogger-start-entry
;;;;;;  weblogger-setup-weblog weblogger-select-configuration) "weblogger"
;;;;;;  "../../../../elisp/package.d/weblogger.el" (19299 19606))
;;; Generated autoloads from ../../../../elisp/package.d/weblogger.el

(autoload 'weblogger-select-configuration "weblogger" "\
Select a previously saved configuration.

\(fn &optional CONFIG)" t nil)

(autoload 'weblogger-setup-weblog "weblogger" "\
Create a profile for a weblog.

\(fn)" t nil)

(autoload 'weblogger-start-entry "weblogger" "\
Start creating a weblog entry in the *weblogger-entry* buffer.
With a prefix, it will check the available weblogs on the server
and prompt for the weblog to post to if multiple ones are
available.

\(fn &optional PROMPT)" t nil)

(autoload 'weblogger-fetch-entries "weblogger" "\
Sync the entry ring with what is on the weblog server.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../elisp/package.d/any-ini-mode.el"
;;;;;;  "../../../../elisp/package.d/cmake-mode.el" "../../../../elisp/package.d/cmake-mode.el"
;;;;;;  "../../../../elisp/package.d/completion-selection.el" "../../../../elisp/package.d/dwa-c++.el"
;;;;;;  "../../../../elisp/package.d/dwa-c++.el" "../../../../elisp/package.d/dwa-compile.el"
;;;;;;  "../../../../elisp/package.d/dwa-rectangle.el" "../../../../elisp/package.d/dwa-rectangle.el"
;;;;;;  "../../../../elisp/package.d/dwa-util.el" "../../../../elisp/package.d/dwa-util.el"
;;;;;;  "../../../../elisp/package.d/git-contrib/git-blame.el" "../../../../elisp/package.d/git-contrib/git.el"
;;;;;;  "../../../../elisp/package.d/gravatar.el" "../../../../elisp/package.d/gravatar.el"
;;;;;;  "../../../../elisp/package.d/initsplit.el" "../../../../elisp/package.d/initsplit.el"
;;;;;;  "../../../../elisp/package.d/jam-mode.el" "../../../../elisp/package.d/jam-mode.el"
;;;;;;  "../../../../elisp/package.d/markdown-mode.el" "../../../../elisp/package.d/markdown-mode.el"
;;;;;;  "../../../../elisp/package.d/maxframe.el" "../../../../elisp/package.d/maxframe.el"
;;;;;;  "../../../../elisp/package.d/misc-cmds.el" "../../../../elisp/package.d/muse-markdown.el"
;;;;;;  "../../../../elisp/package.d/muse-markdown.el" "../../../../elisp/package.d/my-xmlunicode.el"
;;;;;;  "../../../../elisp/package.d/osx-plist.el" "../../../../elisp/package.d/osx-plist.el"
;;;;;;  "../../../../elisp/package.d/policy-switch.el" "../../../../elisp/package.d/psvn.el"
;;;;;;  "../../../../elisp/package.d/smartquotes.el" "../../../../elisp/package.d/smartquotes.el"
;;;;;;  "../../../../elisp/package.d/timeclock-x.el" "../../../../elisp/package.d/timeclock-x.el"
;;;;;;  "../../../../elisp/package.d/unichars.el" "../../../../elisp/package.d/unichars.el"
;;;;;;  "../../../../elisp/package.d/weblogger.el" "../../../../elisp/package.d/xml-rpc.el"
;;;;;;  "../../../../elisp/package.d/xmlunicode.el" "../../../../elisp/package.d/xmlunicode.el"
;;;;;;  "../../../../elisp/package.d/yaoddmuse.el") (19299 19832
;;;;;;  157229))

;;;***

(provide 'my-loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; my-loaddefs.el ends here
