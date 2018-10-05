#!/bin/sh


rm *.aux
rm *.bbl
rm *.blg
rm *.log
rm *~
rm *.dvi

PAPER=gpus-jcst.tex
NAME=`basename $PAPER .tex`
latex $PAPER && latex $PAPER &&  latex $PAPER 
bibtex $NAME
latex $PAPER && latex $PAPER

echo "-----------------------------" 

dvips $NAME.dvi -o && ps2pdf $NAME.ps  &&  rm *.ps

echo "-----------------------------"
