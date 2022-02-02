#!/bin/bash
set -e
set -x

function abs_path() {
    echo $0 | python3 -c 'import sys; import os;print(os.path.abspath(os.path.dirname(sys.stdin.read())))'
}

DIR=`abs_path`
ln -sf $DIR/emacs/.emacs ~/.emacs
ln -sf $DIR/tmux/.tmux.conf ~/.tmux.conf
