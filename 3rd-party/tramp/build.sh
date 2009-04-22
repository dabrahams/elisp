set -e
find . -name '*.elc' -exec rm {} +
autoconf

TARGET="$HOME/.emacs.d/3rd-party/package.d/tramp"
rm -rf "$TARGET"

# TODO: Pick a unique temporary directory name
PREFIX=/tmp/tramp-install
rm -rf "$PREFIX" 

mkdir -p "$TARGET/lisp"
mkdir -p "$TARGET/info"
mkdir -p "$PREFIX/share/emacs"

ln -sf "$TARGET/lisp" "$PREFIX/share/emacs/site-lisp" 
ln -sf "$TARGET/info" "$PREFIX/share/info" 

# EMACS_GVFS controls a dbus dependency, which seems to cause problems on MacOS
export PATH="/Applications/Emacs.app/Contents/MacOS/:$PATH"
./configure --with-contrib --prefix="$PREFIX"

make install
cd contrib
make install

