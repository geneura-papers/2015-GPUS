###############################################################################
# makefile
###############################################################################

DIA = $(wildcard *.dia)
PNG = $(DIA:.dia=.png)
BIB = $(wildcard *.bib)
TEX = $(wildcard *.tex)
TMP = $(TEX:.tex=.aux) $(TEX:.tex=.bbl) $(TEX:.tex=.blg) $(TEX:.tex=.fdb_latexmk) $(TEX:.tex=.fls) $(TEX:.tex=.log) $(TEX:.tex=.out) $(TEX:.tex=.spl)
PDF = $(TEX:.tex=.pdf)

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
	if command -v latexmk &> /dev/null; then \
		latexmk -pdfps $*; \
	elif command -v pdflatex &> /dev/null; then \
		pdflatex $* && bibtex $* && pdflatex $*; \
	fi

###############################################################################

.NOEXPORT:

###############################################################################

