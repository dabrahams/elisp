set -e
find . -name '*.elc' -exec rm {} +
make "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs"
