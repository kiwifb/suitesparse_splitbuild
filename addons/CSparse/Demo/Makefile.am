AM_CPPFLAGS = -I$(top_srcdir)/Include @SUITESPARSECONFIG_CFLAGS@

LDADD = $(top_builddir)/Source/libcsparse.la
noinst_HEADERS = cs_demo.h

check_PROGRAMS = \
	cs_demo1 \
	cs_demo2 \
	cs_demo3

cs_demo1_SOURCES = cs_demo1.c
cs_demo2_SOURCES = cs_demo2.c cs_demo.c
cs_demo3_SOURCES = cs_demo3.c cs_demo.c

check-local: $(check_PROGRAMS)
	- ./cs_demo1 < $(top_srcdir)/Matrix/t1
	- ./cs_demo2 < $(top_srcdir)/Matrix/t1
	- ./cs_demo2 < $(top_srcdir)/Matrix/ash219
	- ./cs_demo2 < $(top_srcdir)/Matrix/bcsstk01
	- ./cs_demo2 < $(top_srcdir)/Matrix/fs_183_1
	- ./cs_demo2 < $(top_srcdir)/Matrix/mbeacxc
	- ./cs_demo2 < $(top_srcdir)/Matrix/west0067
	- ./cs_demo2 < $(top_srcdir)/Matrix/lp_afiro
	- ./cs_demo2 < $(top_srcdir)/Matrix/bcsstk16
	- ./cs_demo3 < $(top_srcdir)/Matrix/bcsstk01
	- ./cs_demo3 < $(top_srcdir)/Matrix/bcsstk16

EXTRA_DIST = README.txt

CLEANFILES = *.dSYM

MAINTAINERCLEANFILES = Makefile.in
