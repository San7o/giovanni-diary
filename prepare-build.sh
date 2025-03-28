#!/bin/sh

# This script is automatically run before generating the static
# content. Any preparation should be done here.

cp $HOME/.emacs.d/init.org content/programming/emacs/init.org
echo -e "\n---\n\n Go Back: [[file:emacs.org][emacs]]" >> content/programming/emacs/init.org

cp style/simple-giovanni.css public/
cp style/favicon.ico public/

mkdir -p public/reading/surroundings
cp -r content/reading/surroundings/images public/reading/surroundings/
