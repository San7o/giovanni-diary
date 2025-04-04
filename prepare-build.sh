#!/bin/sh

# This script is automatically run before generating the static
# content. Any preparation should be done here.

mkdir -p public

cp $HOME/.emacs.d/init.org content/programming/emacs/init.org
echo -e "\n---\n\n Go Back: [[file:emacs.org][emacs]]" >> content/programming/emacs/init.org

# Style
cp style/simple-giovanni.css public/simple.css
cp style/favicon.ico public/

# Fonts
mkdir -p public/fonts
cp -r fonts/Crimson_Text public/fonts/
cp -r fonts/EB_Garamond public/fonts/
cp -r fonts/Inconsolata public/fonts/

# Images
mkdir -p public/reading/surroundings
cp -r content/reading/surroundings/images public/reading/surroundings/
cp -r content/ephemeris/images public/ephemeris
