#!/bin/sh

rm *.aux
rm *.bbl
rm *.blg
rm *.log
rm *~
rm *.dvi

latex gpus-cise.tex && latex gpus-cise.tex &&  latex gpus-cise.tex 
bibtex gpus-cise
latex gpus-cise.tex && latex gpus-cise.tex && latex gpus-cise.tex

echo "-----------------------------" 

dvips gpus-cise.dvi -o && ps2pdf gpus-cise.ps  &&  rm *.ps

echo "-----------------------------"
