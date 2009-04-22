set -e
autoconf
./configure --with-emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
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
