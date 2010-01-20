set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/wanderlust"
rm -rf "$PACKAGE"
mkdir -p "$PACKAGE/info"
BATCHFLAG="-batch -L ../apel -L ../flim -L ../semi --eval '(progn (setq wl-install-utils t)(setq wl-info-lang \"en\")(setq wl-news-lang \"en\"))'"
make check  "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "BATCHFLAG=$BATCHFLAG"
make install install-info "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "LISPDIR=$PACKAGE/lisp" "BATCHFLAG=$BATCHFLAG" "PIXMAPDIR=$PACKAGE/icons" "INFODIR=$PACKAGE/info" <<EOF

EOF
