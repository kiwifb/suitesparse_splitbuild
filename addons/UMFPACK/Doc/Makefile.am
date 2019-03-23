
UMFPACK_UserGuide.pdf:
	-$(LN_S) $(srcdir)/UserGuide.bib .
	$(SED) -f $(srcdir)/UserGuide.sed1 < $(srcdir)/UMFPACK_UserGuide.stex | \
	$(SED) -f $(srcdir)/UserGuide.sed2 | $(EXPAND) -8 > UMFPACK_UserGuide.tex
	$(PDFLATEX) UMFPACK_UserGuide
	$(BIBTEX) UMFPACK_UserGuide
	$(PDFLATEX) UMFPACK_UserGuide
	$(PDFLATEX) UMFPACK_UserGuide

UMFPACK_QuickStart.pdf:
	-$(LN_S) $(srcdir)/UMFPACK_QuickStart.tex .
	$(PDFLATEX) UMFPACK_QuickStart
	$(PDFLATEX) UMFPACK_QuickStart

doc_DATA = ChangeLog

if BUILD_DOCS
pdf-local: UMFPACK_UserGuide.pdf UMFPACK_QuickStart.pdf
all-local: pdf-local
doc_DATA += UMFPACK_UserGuide.pdf UMFPACK_QuickStart.pdf
endif

EXTRA_DIST = gpl.txt License.txt UserGuide.sed1 UserGuide.sed2 UMFPACK_UserGuide.stex UMFPACK_QuickStart.tex UserGuide.bib

CLEANFILES = *.aux *.bbl *.blg *.log *.toc *.pdf *.out UMFPACK_UserGuide.tex
MAINTAINERCLEANFILES = Makefile.in
