#!/bin/bash
set -e
set -x

function abs_path() {
    echo $0 | python3 -c 'import sys; import os;print(os.path.abspath(os.path.dirname(sys.stdin.read())))'
}

DIR=`abs_path`
ESHELL_PROFILE=~/.emacs.d/eshell/profile
ln -sf $DIR/emacs/.emacs ~/.emacs
mkdir -p `dirname $ESHELL_PROFILE`
ln -sf $DIR/emacs/eshell_profile $ESHELL_PROFILE
ln -sf $DIR/tmux/.tmux.conf ~/.tmux.conf
