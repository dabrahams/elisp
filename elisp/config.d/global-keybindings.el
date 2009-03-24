(require 'dwa-util)

;; find-file-at-point -- a feature I've wanted forever and somehow
;; never realized was built into Emacs!
(ffap-bindings)

;; Navigation by words
(global-set-key [(control ?,)] 'backward-word)
(global-set-key [(control ?.)] 'forward-word)

;; Navigation to other windows (panes)
(global-set-key "\C-x\C-n" 'other-window)  ; Normally bound to set-goal-column
(global-set-key "\C-x\C-p" 'my-other-window-backward) ; Normally bound to mark-page

;; This is the way I like it; the defaults go to the beginning and/or end of line
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)

(global-set-key [( control ?\( )] 'my-matching-paren)

;; This is normally set to bring up a buffer list, but there are many other
;; ways to do this seldom-desired function (e.g. C-mouse1, or look at the
;; "Buffers" menu at the top of the frame).
(global-set-key "\C-x\C-b" 'my-switch-to-previous-buffer)

(global-set-key [f12] 'ps-print-buffer)

;; Lots of modes use the tab key to perform indentation. Sometimes you just want
;; to move to the right a bit when you've already got the line indented
(global-set-key [(control tab)] 'tab-to-tab-stop)

;; Miscellaneous
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key "\C-x\C-k" 'my-kill-buffer)
(global-set-key [f3] 'eval-last-sexp)
(global-set-key "\C-xr\C-k" 'my-kill-rectangle)
(global-set-key "\C-xr\C-y" 'my-yank-replace-rectangle)
(global-set-key "\C-xr\C-w" 'my-save-rectangle)
(global-set-key "\C-x\M-Q" 'my-force-writable)

(require 'windmove)
(windmove-default-keybindings 'meta)

(define-key global-map [(control meta ?r)] 'remember)
