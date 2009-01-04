(setq-default
 ;; By default, ediff all in one frame.
 ediff-window-setup-function 'ediff-setup-windows-plain

 ;; view diffs side-by-side
 ediff-split-window-function 'split-window-horizontally

 ;; only highlight the selected diff (keeps down gray cruft onscreen)
 ediff-highlight-all-diffs nil

 ;; Show me accurate unified diffs by default
 ediff-custom-diff-options "-du"

 ;; Use accurate diffs internally
 ediff-diff-options "-d"

 ;; prompt to remove unmodified buffers at session end
 ediff-keep-variants nil
)