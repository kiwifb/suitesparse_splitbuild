
KLU_UserGuide.pdf:
	printf '\\begin{verbatim}\n' > klu_h.tex
	expand -8 $(top_srcdir)/Include/klu.h >> klu_h.tex
	printf '\\end{verbatim}\n' >> klu_h.tex
	printf '\\begin{verbatim}\n' > btf_h.tex
	printf 'See your btf.h local install\n' >> btf_h.tex
	printf '\\end{verbatim}\n' >> btf_h.tex
	printf '\\begin{verbatim}\n' > klu_simple_c.tex
	expand -8 $(top_srcdir)/Demo/klu_simple.c >> klu_simple_c.tex
	printf '\\end{verbatim}\n' >> klu_simple_c.tex
	-ln -s $(srcdir)/*.{tex,bib} .
	$(PDFLATEX) KLU_UserGuide
	$(BIBTEX)  KLU_UserGuide
	$(PDFLATEX) KLU_UserGuide
	$(PDFLATEX) KLU_UserGuide

doc_DATA = ChangeLog

if BUILD_DOCS
pdf-local: KLU_UserGuide.pdf
all-local: pdf-local
doc_DATA += KLU_UserGuide.pdf palamadai_e.pdf
endif

EXTRA_DIST = lesser.txt KLU_UserGuide.tex KLU_UserGuide.bib palamadai_e.pdf

CLEANFILES = *.aux *.bbl *.blg *.log *.toc *.pdf klu_h.tex btf_h.tex klu_simple_c.tex
MAINTAINERCLEANFILES = Makefile.in
