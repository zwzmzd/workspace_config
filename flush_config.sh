#!/bin/bash
set -e
set -x

function abs_path() {
    echo $0 | python3 -c 'import sys; import os;print(os.path.abspath(os.path.dirname(sys.stdin.read())))'
}

DIR=`abs_path`
ESHELL_PROFILE=~/.emacs.d/eshell/profile
GIT_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/git"
ln -sf $DIR/emacs/.emacs ~/.emacs
mkdir -p `dirname $ESHELL_PROFILE`
ln -sf $DIR/emacs/eshell_profile $ESHELL_PROFILE
ln -sf $DIR/tmux/.tmux.conf ~/.tmux.conf
ln -sf $DIR/clang-format/.clang-format ~/.clang-format
mkdir -p "$GIT_CONFIG_HOME"
ln -sf "$DIR/git/config" "$GIT_CONFIG_HOME/config"
ln -sf "$DIR/git/attributes" "$GIT_CONFIG_HOME/attributes"
