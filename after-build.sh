#!/bin/sh

# This script will be run after the build

# Remove unwanted index title
sed -i '/G<\/h2>/d' public/theindex.html
