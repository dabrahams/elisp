set -e
set -x
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/color-theme"
rm -rf "$PACKAGE"
mkdir -p "$PACKAGE/info"
# BATCHFLAG="-batch -L ../apel -L ../flim -L ../semi --eval '(progn (setq wl-install-utils t)(setq wl-info-lang \"en\")(setq wl-news-lang \"en\"))'"
# make check  "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "BATCHFLAG=$BATCHFLAG"
make install-bin "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "ELISPDIR=$PACKAGE/lisp" "BATCHFLAG=$BATCHFLAG" "PIXMAPDIR=$PACKAGE/icons" "INFODIR=$PACKAGE/info"
