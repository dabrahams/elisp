######################
# ./.disabled/dvc/build.sh
######################
set -e
autoconf
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/dvc"
rm -rf "$PACKAGE"
rm -rf 'xxbuild'
mkdir 'xxbuild'
pushd 'xxbuild'
export PATH="Applications/Emacs.app/Contents/MacOS:$PATH"
../configure
mkdir -p "$PACKAGE/info"
make install "lispdir=$PACKAGE/lisp" "PIXMAPDIR=$PACKAGE/icons" "info_dir=$PACKAGE/info"
popd
rm -rf xxbuild
######################
# ./.disabled/eproject/build.sh
######################
set -e
TARGET="$HOME/.emacs.d/3rd-party/package.d/eproject"
rm -rf "$TARGET"
cp -r . "$TARGET"
rm -r "$TARGET"/.git*
export PATH="/Applications/Emacs.app/Contents/MacOS/:$PATH"
emacs -l ~/.emacs -batch --eval "(byte-recompile-directory \"$TARGET\" 0 t)"
######################
# ./.disabled/g-client/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
make "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs"
######################
# ./apel/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/apel"
rm -rf "$PACKAGE"
make install "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "LISPDIR=$PACKAGE/lisp"
######################
# ./bbdb/build.sh
######################
set -e
if [ -e Makefile ] ; then 
    make distclean
fi
autoconf
./configure --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs

# This necessary file seems to get killed by "make clean!"
if [ ! -e loadpath.el ] ; then
    cat > loadpath.el <<EOF
(setq load-path (delete "" (append (list ".") load-path)))
EOF
fi

make 

PREFIX="$HOME/.emacs.d/3rd-party/package.d/bbdb"

rm -rf "$PREFIX"

function install()
{
    local subdir="$1"
    local target="$PREFIX/$subdir"
    mkdir -p "$target"
    shift
    set +e
    cp -v ${@/#/"$subdir/*."} "$target"
}

install lisp el elc
install tex tex
install texinfo info

# This one is in the bbdb directions but the files don't seem to exist
install texinfo info-* || echo "no info-* files"
######################
# ./bibl-mode-1.27/build.sh
######################
set -e
make "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs -L ." 

TARGET="$HOME/.emacs.d/3rd-party/package.d/bibl-mode"

# This package has such a simple structure that it can just be copied
mkdir -p "$TARGET"
cp -R ./ "$TARGET"
######################
# ./color-theme-6.6.0/build.sh
######################
set -e
set -x
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/color-theme"
rm -rf "$PACKAGE"
mkdir -p "$PACKAGE/info"
make install-bin "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "ELISPDIR=$PACKAGE/lisp" "PIXMAPDIR=$PACKAGE/icons" "INFODIR=$PACKAGE/info"
######################
# ./flim/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/flim"
rm -rf "$PACKAGE"
make install "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "LISPDIR=$PACKAGE/lisp" "FLAGS=-L ../apel -batch -q -no-site-file -l FLIM-MK"
######################
# ./magit/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
# ./autogen.sh
# TODO: Pick a unique temporary directory name
DESTDIR="$HOME/.emacs.d/3rd-party/package.d/magit"
rm -rf "$DESTDIR"
export PATH="/Applications/Emacs.app/Contents/MacOS/:$PATH"
make
echo INSTALLing
make DESTDIR=$DESTDIR PREFIX=. install
######################
# ./mailcrypt/build.sh
######################
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
######################
# ./muse-el/build.sh
######################
set -e
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/muse"
rm -rf "$PACKAGE"
mkdir -p "$PACKAGE/info/muse"
make "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "ELISPDIR=$PACKAGE/lisp" "INFODIR=$PACKAGE/info" realclean install
######################
# ./org-mode/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/org-mode"
rm -rf "$PACKAGE"
make EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs lispdir="$PACKAGE/lisp" infodir="$PACKAGE/info" install install-info
find contrib -name '*.el' -exec /Applications/Emacs.app/Contents/MacOS/Emacs -batch -q -eval "(progn (add-to-list (quote load-path) (expand-file-name \"./lisp/\")) (add-to-list (quote load-path) \"/usr/local/share/emacs/site-lisp\"))" -f batch-byte-compile {} ';'
cp -r contrib "$PACKAGE"
######################
# ./planner-el/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/planner"
rm -rf "$PACKAGE"
# This is a total hack.  I don't know how people normally install this
# package, but building it requires the ability to find a bunch of
# other packages, like bbdb.  So you either have to have them
# installed at your site or you need to do something to ensure they
# can be seen.  I just have it load my .emacs, which sets up the load
# paths (and a whole lot more).
make "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" SITEFLAG="--no-site-file -l ~/.emacs" ELISPDIR="$PACKAGE/lisp" INFODIR="$PACKAGE/info" install
find contrib -name '*.el' -exec /Applications/Emacs.app/Contents/MacOS/Emacs -batch -q -eval "(progn (add-to-list (quote load-path) (expand-file-name \"./lisp/\")) (add-to-list (quote load-path) \"/usr/local/share/emacs/site-lisp\"))" -f batch-byte-compile {} ';'
cp -r contrib "$PACKAGE"
######################
# ./remember-el/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/remember"
rm -rf "$PACKAGE"
# This is a total hack.  I don't know how people normally install this
# package, but building it requires the ability to find bibl-mode.  So
# you either have to have it installed at your site or you need to do
# something to ensure it can be seen.  I just have it load my .emacs,
# which sets up the load paths (and a whole lot more).
make "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" SITEFLAG="--no-site-file -l ~/.emacs" ELISPDIR="$PACKAGE/lisp" INFODIR="$PACKAGE/info" install


######################
# ./semi/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/semi"
rm -rf "$PACKAGE"
make install "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "LISPDIR=$PACKAGE/lisp" "FLAGS=-L ../apel -L ../flim -batch -q -no-site-file -l SEMI-MK"
######################
# ./w3m-el/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
autoconf
TARGET="$HOME/.emacs.d/3rd-party/package.d/w3m"
./configure --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs --with-lispdir="$TARGET/lisp" --infodir="$TARGET/lisp" # --with-icondir="$TARGET/icons"
make install-en install-icons30
######################
# ./wanderlust/build.sh
######################
set -e
find . -name '*.elc' -exec rm {} +
PACKAGE="$HOME/.emacs.d/3rd-party/package.d/wanderlust"
rm -rf "$PACKAGE"
mkdir -p "$PACKAGE/info"
BATCHFLAG="-batch -L ../apel -L ../flim -L ../semi --eval '(progn (setq wl-install-utils t)(setq wl-info-lang \"en\")(setq wl-news-lang \"en\"))'"
make check  "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "BATCHFLAG=$BATCHFLAG"
make install install-info "EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs" "LISPDIR=$PACKAGE/lisp" "BATCHFLAG=$BATCHFLAG" "PIXMAPDIR=$PACKAGE/icons" "INFODIR=$PACKAGE/info" <<EOF

EOF
