set -e
autoconf
PREFIX=/tmp/mailcrypt-install
rm -rf "$PREFIX" 
TARGET="$HOME/.emacs.d/3rd-party/package.d/mailcrypt"
rm -rf "$TARGET"
mkdir -p "$TARGET/lisp"
mkdir -p "$TARGET/info"
mkdir -p "$PREFIX/share/emacs"
ln -sf "$TARGET/lisp" "$PREFIX/share/emacs/site-lisp" 
ln -sf "$TARGET/info" "$PREFIX/share/info" 
export PATH="/Applications/Emacs.app/Contents/MacOS/:$PATH"
./configure "--prefix=$PREFIX"
# deal with
# https://sourceforge.net/tracker/?func=detail&aid=2778193&group_id=397&atid=100397
# by defining INFOFILES
make INFOFILES=mailcrypt.info
make INFOFILES=mailcrypt.info install
