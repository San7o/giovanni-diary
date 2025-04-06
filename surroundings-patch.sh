#!/bin/sh

# This script is supposed to be run after generating the .tex file.
# It add various modifications to the tex file and compiles It to
# pdf using elatex.

sed -i '25i\\\begin{titlepage}\
  \\centering\
  {\\Huge\\bfseries Surroundings \\par}\
  Giovannis Diary\
\\end{titlepage}' latex/surroundings-final.tex

sed -i '4i\\\usepackage{float}\
\\let\\origfigure\\figure\
\\let\\endorigfigure\\endfigure\
\\renewenvironment{figure}[1][H]{\\origfigure[#1]}{\\endorigfigure}' latex/surroundings-final.tex

sed -i '3i\
\\usepackage{fontspec}\
\\setmainfont{Inconsolata}[\
    Path = ../fonts/Inconsolata/static/,\
    Extension = .ttf,\
    UprightFont = *-Regular,\
    BoldFont = *-Bold,\
    ItalicFont = *-Bold,\
    BoldItalicFont = *-Bold\
]' latex/surroundings-final.tex

sed -i 's/\[htbp\]//g' latex/surroundings-final.tex

sed -i 's/---/\\newpage/g' latex/surroundings-final.tex

cd latex
xelatex surroundings-final.tex
cp surroundings-final.pdf ../public/reading/surroundings/Surroundings.pdf
