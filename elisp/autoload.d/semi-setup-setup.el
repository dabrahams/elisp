;; This is needed because mime-setup-enable-inline-html forces the
;; score for html to 3
(set-alist 'mime-view-type-subtype-score-alist '(text . html) 0)