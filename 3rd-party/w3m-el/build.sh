set -e
find . -name '*.elc' -exec rm {} +
autoconf
TARGET="$HOME/.emacs.d/3rd-party/package.d/w3m"
./configure --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs --with-lispdir="$TARGET/lisp" --infodir="$TARGET/lisp" # --with-icondir="$TARGET/icons"
make install-en install-icons30
