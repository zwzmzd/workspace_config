#!/bin/bash

set -e
set -x

DIR=`dirname $0`
ln -sf `realpath $DIR/emacs/.emacs` ~/.emacs
ln -sf `realpath $DIR/tmux/.tmux.conf` ~/.tmux.conf
