#!/bin/sh

# This script is automatically run before generating the static
# content. Any preparation should be done here.

mkdir -p public

cp $HOME/.emacs.d/init.org content/programming/emacs/init.org
sed -i '2i\[[file:../../index.org][Giovannis Diary]] > [[file:../programming.org][Programming]] > [[file:emacs.org][Emacs]] >' content/programming/emacs/init.org
echo -e "\n-----\n\n Travel: [[file:emacs.org][Emacs]], [[file:../../theindex.org][Index]]" >> content/programming/emacs/init.org

# Style
cp style/simple-giovanni.css public/simple.css
cp style/favicon.ico public/
cp style/logo.png public/

# Fonts
mkdir -p public/fonts
cp -r fonts/Inconsolata public/fonts/

# Images
mkdir -p public/reading/surroundings
cp -r content/reading/surroundings/images public/reading/surroundings/
cp -r content/ephemeris/images public/ephemeris/
cp -r content/stash/photography/images public/stash/photography

# Dump git commit history
git log --pretty=format:"- %ad %s" --date=short > content/git-history.txt
