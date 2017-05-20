###############################################################################
# makefile
###############################################################################

DIA = $(wildcard *.dia)
EPS = $(DIA:.dia=.eps)
PNG = $(DIA:.dia=.png)
BIB = $(wildcard *.bib)
TEX = $(wildcard *.tex)
TMP = $(TEX:.tex=.aux) $(TEX:.tex=.bbl) $(TEX:.tex=.blg) $(TEX:.tex=.fdb_latexmk) $(TEX:.tex=.fls) $(TEX:.tex=.log) $(TEX:.tex=.out) $(TEX:.tex=.spl)
PDF = $(TEX:.tex=.pdf)

###############################################################################

all: $(PNG) $(EPS) $(PDF)

auto: $(PNG) $(EPS)
	latexmk -pdfps -pvc

clean:
	-latexmk -C
	-rm -fv $(TMP) *~

###############################################################################

%.eps: %.dia
	dia -e $@ -t eps-builtin $<

%.png: %.dia
	dia -e $@ $<

%.pdf: $(PNG) $(EPS) %.bib %.tex
	if command -v latexmk &> /dev/null; then \
		latexmk -pdfps $*; \
	elif command -v pdflatex &> /dev/null; then \
		pdflatex $* && bibtex $* && pdflatex $*; \
	fi

###############################################################################

.NOEXPORT:

###############################################################################

