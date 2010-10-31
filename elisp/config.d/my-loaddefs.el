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

;;;### (autoloads (boxquote-unbox boxquote-unbox-region boxquote-fill-paragraph
;;;;;;  boxquote-kill boxquote-narrow-to-boxquote-content boxquote-narrow-to-boxquote
;;;;;;  boxquote-text boxquote-where-is boxquote-shell-command boxquote-describe-key
;;;;;;  boxquote-describe-variable boxquote-describe-function boxquote-boxquote
;;;;;;  boxquote-paragraph boxquote-defun boxquote-yank boxquote-kill-ring-save
;;;;;;  boxquote-insert-buffer boxquote-insert-file boxquote-buffer
;;;;;;  boxquote-region boxquote-title) "boxquote" "../../../../elisp/package.d/boxquote.el"
;;;;;;  (19634 24770))
;;; Generated autoloads from ../../../../elisp/package.d/boxquote.el

(autoload 'boxquote-title "boxquote" "\
Set the title of the current boxquote to TITLE.

If TITLE is an empty string the title is removed. Note that the title will
be formatted using `boxquote-title-format'.

\(fn TITLE)" t nil)

(autoload 'boxquote-region "boxquote" "\
Draw a box around the left hand side of a region bounding START and END.

\(fn START END)" t nil)

(autoload 'boxquote-buffer "boxquote" "\
Apply `boxquote-region' to a whole buffer.

\(fn)" t nil)

(autoload 'boxquote-insert-file "boxquote" "\
Insert the contents of a file, boxed with `boxquote-region'.

If `boxquote-title-files' is non-nil the boxquote will be given a title that
is the result of applying `boxquote-file-title-function' to FILENAME.

\(fn FILENAME)" t nil)

(autoload 'boxquote-insert-buffer "boxquote" "\
Insert the contents of a buffer, boxes with `boxquote-region'.

If `boxquote-title-buffers' is non-nil the boxquote will be given a title that
is the result of applying `boxquote-buffer-title-function' to BUFFER.

\(fn BUFFER)" t nil)

(autoload 'boxquote-kill-ring-save "boxquote" "\
Like `kill-ring-save' but remembers a title if possible.

The title is acquired by calling `boxquote-kill-ring-save-title'. The title
will be used by `boxquote-yank'.

\(fn)" t nil)

(autoload 'boxquote-yank "boxquote" "\
Do a `yank' and box it in with `boxquote-region'.

If the yanked entry was placed on the kill ring with
`boxquote-kill-ring-save' the resulting boxquote will be titled with
whatever `boxquote-kill-ring-save-title' returned at the time.

\(fn)" t nil)

(autoload 'boxquote-defun "boxquote" "\
Apply `boxquote-region' the current defun.

\(fn)" t nil)

(autoload 'boxquote-paragraph "boxquote" "\
Apply `boxquote-region' to the current paragraph.

\(fn)" t nil)

(autoload 'boxquote-boxquote "boxquote" "\
Apply `boxquote-region' to the current boxquote.

\(fn)" t nil)

(autoload 'boxquote-describe-function "boxquote" "\
Call `describe-function' and boxquote the output into the current buffer.

\(fn)" t nil)

(autoload 'boxquote-describe-variable "boxquote" "\
Call `describe-variable' and boxquote the output into the current buffer.

\(fn)" t nil)

(autoload 'boxquote-describe-key "boxquote" "\
Call `describe-key' and boxquote the output into the current buffer.

If the call to this command is prefixed with \\[universal-argument] you will also be
prompted for a buffer. The key defintion used will be taken from that buffer.

\(fn KEY)" t nil)

(autoload 'boxquote-shell-command "boxquote" "\
Call `shell-command' with COMMAND and boxquote the output.

\(fn COMMAND)" t nil)

(autoload 'boxquote-where-is "boxquote" "\
Call `where-is' with DEFINITION and boxquote the result.

\(fn DEFINITION)" t nil)

(autoload 'boxquote-text "boxquote" "\
Insert TEXT, boxquoted.

\(fn TEXT)" t nil)

(autoload 'boxquote-narrow-to-boxquote "boxquote" "\
Narrow the buffer to the current boxquote.

\(fn)" t nil)

(autoload 'boxquote-narrow-to-boxquote-content "boxquote" "\
Narrow the buffer to the content of the current boxquote.

\(fn)" t nil)

(autoload 'boxquote-kill "boxquote" "\
Kill the boxquote and its contents.

\(fn)" t nil)

(autoload 'boxquote-fill-paragraph "boxquote" "\
Perform a `fill-paragraph' inside a boxquote.

\(fn ARG)" t nil)

(autoload 'boxquote-unbox-region "boxquote" "\
Remove a box created with `boxquote-region'.

\(fn START END)" t nil)

(autoload 'boxquote-unbox "boxquote" "\
Remove the boxquote that contains `point'.

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
;;;;;;  (19442 59238))
;;; Generated autoloads from ../../../../elisp/package.d/git-contrib/git-blame.el

(autoload 'git-blame-mode "git-blame" "\
Toggle minor mode for displaying Git blame

With prefix ARG, turn the mode on if ARG is positive.

\(fn &optional ARG)" t nil)

(autoload 'git-reblame "git-blame" "\
Recalculate all blame information in the current buffer

\(fn)" t nil)

;;;***

;;;### (autoloads (markdown-mode) "markdown-mode" "../../../../elisp/package.d/markdown-mode.el"
;;;;;;  (18967 24446))
;;; Generated autoloads from ../../../../elisp/package.d/markdown-mode.el

(autoload 'markdown-mode "markdown-mode" "\
Major mode for editing Markdown files.

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

;;;### (autoloads (php-mode php-file-patterns) "php-mode" "../../../../elisp/package.d/php-mode.el"
;;;;;;  (19328 36945))
;;; Generated autoloads from ../../../../elisp/package.d/php-mode.el

(defvar php-file-patterns '("\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'") "\
List of file patterns for which to automatically invoke `php-mode'.")

(custom-autoload 'php-file-patterns "php-mode" nil)

(autoload 'php-mode "php-mode" "\
Major mode for editing PHP code.

\\{php-mode-map}

\(fn)" t nil)

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
;;;;;;  "../../../../elisp/package.d/weblogger.el" (19661 49660))
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

;;;### (autoloads (yas/minor-mode yas/snippet-dirs) "yasnippet" "../../../../elisp/package.d/yasnippet.el"
;;;;;;  (19518 36310))
;;; Generated autoloads from ../../../../elisp/package.d/yasnippet.el

(defvar yas/snippet-dirs nil "\
Directory or list of snippet dirs for each major mode.

The directory where user-created snippets are to be stored. Can
also be a list of directories. In that case, when used for
bulk (re)loading of snippets (at startup or via
`yas/reload-all'), directories appearing earlier in the list
shadow other dir's snippets. Also, the first directory is taken
as the default for storing the user's new snippets.")

(custom-autoload 'yas/snippet-dirs "yasnippet" nil)

(autoload 'yas/minor-mode "yasnippet" "\
Toggle YASnippet mode.

When YASnippet mode is enabled, the `tas/trigger-key' key expands
snippets of code depending on the mode.

With no argument, this command toggles the mode.
positive prefix argument turns on the mode.
Negative prefix argument turns off the mode.

You can customize the key through `yas/trigger-key'.

Key bindings:
\\{yas/minor-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (color-theme-zenburn) "zenburn" "../../../../elisp/package.d/zenburn.el"
;;;;;;  (19623 53521))
;;; Generated autoloads from ../../../../elisp/package.d/zenburn.el

(autoload 'color-theme-zenburn "zenburn" "\
Just some alien fruit salad to keep you in the zone.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../elisp/package.d/ac-anything.el"
;;;;;;  "../../../../elisp/package.d/ac-anything.el" "../../../../elisp/package.d/ac-anything.el"
;;;;;;  "../../../../elisp/package.d/ahg.el" "../../../../elisp/package.d/ahg.el"
;;;;;;  "../../../../elisp/package.d/any-ini-mode.el" "../../../../elisp/package.d/anything.el"
;;;;;;  "../../../../elisp/package.d/anything.el" "../../../../elisp/package.d/anything.el"
;;;;;;  "../../../../elisp/package.d/boxquote.el" "../../../../elisp/package.d/cmake-mode.el"
;;;;;;  "../../../../elisp/package.d/cmake-mode.el" "../../../../elisp/package.d/cmake-mode.el"
;;;;;;  "../../../../elisp/package.d/cmake-mode.el" "../../../../elisp/package.d/completion-selection.el"
;;;;;;  "../../../../elisp/package.d/completion-selection.el" "../../../../elisp/package.d/completion-selection.el"
;;;;;;  "../../../../elisp/package.d/dwa-c++.el" "../../../../elisp/package.d/dwa-c++.el"
;;;;;;  "../../../../elisp/package.d/dwa-c++.el" "../../../../elisp/package.d/dwa-c++.el"
;;;;;;  "../../../../elisp/package.d/dwa-compile.el" "../../../../elisp/package.d/dwa-rectangle.el"
;;;;;;  "../../../../elisp/package.d/dwa-rectangle.el" "../../../../elisp/package.d/dwa-rectangle.el"
;;;;;;  "../../../../elisp/package.d/dwa-rectangle.el" "../../../../elisp/package.d/dwa-util.el"
;;;;;;  "../../../../elisp/package.d/dwa-util.el" "../../../../elisp/package.d/dwa-util.el"
;;;;;;  "../../../../elisp/package.d/dwa-util.el" "../../../../elisp/package.d/elscreen/elscreen-1.4.6/elscreen.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-color-theme-0.0.0/elscreen-color-theme.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-dired-0.1.0/elscreen-dired.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-dnd-0.0.0/elscreen-dnd.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-gf-1.5.3/elscreen-gf.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-goby-0.0.0/elscreen-goby.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-howm-0.1.3/elscreen-howm.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-server-0.2.0/elscreen-server.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-speedbar-0.0.0/elscreen-speedbar.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-w3m-0.2.2/elscreen-w3m.el"
;;;;;;  "../../../../elisp/package.d/elscreen/elscreen-wl-0.8.0/elscreen-wl.el"
;;;;;;  "../../../../elisp/package.d/filladapt.el" "../../../../elisp/package.d/filladapt.el"
;;;;;;  "../../../../elisp/package.d/git-contrib/git-blame.el" "../../../../elisp/package.d/git-contrib/git.el"
;;;;;;  "../../../../elisp/package.d/gravatar.el" "../../../../elisp/package.d/gravatar.el"
;;;;;;  "../../../../elisp/package.d/gravatar.el" "../../../../elisp/package.d/gravatar.el"
;;;;;;  "../../../../elisp/package.d/initsplit.el" "../../../../elisp/package.d/jam-mode.el"
;;;;;;  "../../../../elisp/package.d/jam-mode.el" "../../../../elisp/package.d/jam-mode.el"
;;;;;;  "../../../../elisp/package.d/jam-mode.el" "../../../../elisp/package.d/markdown-mode.el"
;;;;;;  "../../../../elisp/package.d/markdown-mode.el" "../../../../elisp/package.d/markdown-mode.el"
;;;;;;  "../../../../elisp/package.d/maxframe.el" "../../../../elisp/package.d/maxframe.el"
;;;;;;  "../../../../elisp/package.d/maxframe.el" "../../../../elisp/package.d/maxframe.el"
;;;;;;  "../../../../elisp/package.d/mercurial.el" "../../../../elisp/package.d/mercurial.el"
;;;;;;  "../../../../elisp/package.d/misc-cmds.el" "../../../../elisp/package.d/muse-markdown.el"
;;;;;;  "../../../../elisp/package.d/muse-markdown.el" "../../../../elisp/package.d/muse-markdown.el"
;;;;;;  "../../../../elisp/package.d/muse-markdown.el" "../../../../elisp/package.d/my-xmlunicode.el"
;;;;;;  "../../../../elisp/package.d/my-xmlunicode.el" "../../../../elisp/package.d/my-xmlunicode.el"
;;;;;;  "../../../../elisp/package.d/osx-plist.el" "../../../../elisp/package.d/osx-plist.el"
;;;;;;  "../../../../elisp/package.d/osx-plist.el" "../../../../elisp/package.d/osx-plist.el"
;;;;;;  "../../../../elisp/package.d/php-mode.el" "../../../../elisp/package.d/policy-switch.el"
;;;;;;  "../../../../elisp/package.d/policy-switch.el" "../../../../elisp/package.d/policy-switch.el"
;;;;;;  "../../../../elisp/package.d/psvn.el" "../../../../elisp/package.d/smartquotes.el"
;;;;;;  "../../../../elisp/package.d/smartquotes.el" "../../../../elisp/package.d/smartquotes.el"
;;;;;;  "../../../../elisp/package.d/smartquotes.el" "../../../../elisp/package.d/timeclock-x.el"
;;;;;;  "../../../../elisp/package.d/timeclock-x.el" "../../../../elisp/package.d/timeclock-x.el"
;;;;;;  "../../../../elisp/package.d/timeclock-x.el" "../../../../elisp/package.d/unichars.el"
;;;;;;  "../../../../elisp/package.d/unichars.el" "../../../../elisp/package.d/unichars.el"
;;;;;;  "../../../../elisp/package.d/unichars.el" "../../../../elisp/package.d/weblogger.el"
;;;;;;  "../../../../elisp/package.d/wl-gravatar.el" "../../../../elisp/package.d/xml-rpc.el"
;;;;;;  "../../../../elisp/package.d/xmlunicode.el" "../../../../elisp/package.d/xmlunicode.el"
;;;;;;  "../../../../elisp/package.d/xmlunicode.el" "../../../../elisp/package.d/xmlunicode.el"
;;;;;;  "../../../../elisp/package.d/yaoddmuse.el" "../../../../elisp/package.d/yaoddmuse.el"
;;;;;;  "../../../../elisp/package.d/yaoddmuse.el" "../../../../elisp/package.d/yasnippet-debug.el"
;;;;;;  "../../../../elisp/package.d/yasnippet-debug.el" "../../../../elisp/package.d/yasnippet.el"
;;;;;;  "../../../../elisp/package.d/zenburn-wl.el" "../../../../elisp/package.d/zenburn-wl.el"
;;;;;;  "../../../../elisp/package.d/zenburn-wl.el" "../../../../elisp/package.d/zenburn.el")
;;;;;;  (19661 49885 744150))

;;;***

(provide 'my-loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; my-loaddefs.el ends here
