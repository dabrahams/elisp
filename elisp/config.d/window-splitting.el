(unless (boundp 'split-window-preferred-function)
  (defadvice split-window (before by-default-split-horizontally activate)
    "When the system is going to split the window and we have lots
of horizontal space, I want to split it horizontally!  The
default of splitting vertically (i.e. with a horizontal divider)
leaves me looking at really long lines through really narrow
spaces, which kinda blows."
    (when (and (not (ad-get-arg 2)) (> (window-width (or (ad-get-arg 0) (selected-window))) 160))
        (ad-set-arg 2 t)
        (ad-set-arg 1 nil)
        ))

  (defadvice split-window-vertically (around explicit-split-vertically activate protect)
    "See split-window advice \"by-default-split-horizontally\".
However, if the system thinks it knows what it's doing,
i.e. someone called split-window-vertically, I want to respect
that"
    (ad-disable-advice 'split-window 'before 'by-default-split-horizontally)
    (ad-activate 'split-window)
    ad-do-it
    (ad-enable-advice 'split-window 'before 'by-default-split-horizontally)
    (ad-activate 'split-window)
    )
)
