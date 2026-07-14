#!/bin/bash
set -e
set -x

DIR="$(CDPATH= cd "$(dirname "$0")" && pwd -P)"
ESHELL_PROFILE="$HOME/.emacs.d/eshell/profile"
GIT_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/git"
ln -sf "$DIR/emacs/.emacs" "$HOME/.emacs"
mkdir -p "$(dirname "$ESHELL_PROFILE")"
ln -sf "$DIR/emacs/eshell_profile" "$ESHELL_PROFILE"
ln -sf "$DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DIR/clang-format/.clang-format" "$HOME/.clang-format"
mkdir -p "$GIT_CONFIG_HOME"
ln -sf "$DIR/git/config" "$GIT_CONFIG_HOME/config"
ln -sf "$DIR/git/attributes" "$GIT_CONFIG_HOME/attributes"
