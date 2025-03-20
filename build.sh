#!/bin/sh
cp $HOME/.emacs.d/init.org content/programming/emacs/init.org
emacs -Q --script build-site.el
