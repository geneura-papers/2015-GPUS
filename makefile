###############################################################################
# makefile
###############################################################################

DIA = $(wildcard *.dia)
PNG = $(DIA:.dia=.png)
BIB = $(wildcard *.bib)
TEX = $(wildcard *.tex)
TMP = $(TEX:.tex=.aux) $(TEX:.tex=.bbl) $(TEX:.tex=.blg) $(TEX:.tex=.fdb_latexmk) $(TEX:.tex=.fls) $(TEX:.tex=.log) $(TEX:.tex=.out) $(TEX:.tex=.spl)
PDF = $(TEX:.tex=.pdf)
PDFLATEX := $(shell pdflatex --version  2> /dev/null)

ifdef PDFLATEX
	LATEX=pdflatex
else
	LATEX=latexmk -pdfps -f
endif

###############################################################################

all: $(PNG) $(PDF)

auto: $(PNG)
	latexmk -pdfps -pvc

clean:
	-latexmk -C
	-rm -fv $(TMP) *~

###############################################################################

%.png: %.dia
	dia -e $@ $<

%.pdf: %.bib %.tex
	$(LATEX) $* && bibtex $(basename $<) && $(LATEX) $*	

###############################################################################

.NOEXPORT:

###############################################################################

