#!/bin/sh


rm *.aux
rm *.bbl
rm *.blg
rm *.log
rm *~
rm *.dvi

PAPER=gpus-jcst.tex
NAME=`basename $PAPER .tex`
pdflatex $PAPER && pdflatex $PAPER 
bibtex $NAME
pdflatex $PAPER && pdflatex $PAPER 

