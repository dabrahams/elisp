set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/flim"
rm -rf "$PACKAGE"
make install "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "LISPDIR=$PACKAGE/lisp" "FLAGS=-L ../apel -batch -q -no-site-file -l FLIM-MK"
