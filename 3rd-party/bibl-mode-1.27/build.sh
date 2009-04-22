set -e
make "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs -L ." 

TARGET="$HOME/.emacs.d/3rd-party/package.d/bibl-mode"

# This package has such a simple structure that it can just be copied
mkdir -p "$TARGET"
cp -R ./ "$TARGET"
