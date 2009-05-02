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
