set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/apel"
rm -rf "$PACKAGE"
make install "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "LISPDIR=$PACKAGE/lisp"
