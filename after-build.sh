#!/bin/sh

# This script will be run after the build

set -e

# Remove unwanted index title
sed -i '/G<\/h2>/d' public/theindex.html

# Center the div vertically
sed -i 's/<\/head>/<style>body { display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; } .outline2 { padding: 2rem; border-radius: 8px;} .content {text-align: center;} <\/style><\/head>/' public/index.html
sed -i 's/<\/head>/<style>body { display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; } .outline2 { padding: 2rem; border-radius: 8px;} .content {text-align: center;} <\/style><\/head>/' public/order.html

WORDS=$(find content/ -type f -name "*.org" -print0 | xargs -0 cat | wc -w)
FILES=$(find content/ -type f -not -path "*ltximg*" | wc -l)
sed -i "s/WORDS/$WORDS/" public/first-page.html
sed -i "s/FILES/$FILES/" public/first-page.html

# Generate sitemap
find public/ -type f | sed 's/public/https:\/\/san7o.github.io\/giovanni-diary/g' > public/sitemap.txt

# Copy robots.txt
cp robots.txt public/
