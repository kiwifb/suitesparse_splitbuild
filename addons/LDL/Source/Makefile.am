AM_CPPFLAGS = -I$(top_srcdir)/Include @SUITESPARSECONFIG_CFLAGS@
AM_LDFLAGS = -version-info @LT_CURRENT@:@LT_REVISION@:@LT_AGE@

LDLSRC = ldl.c $(top_srcdir)/Include/ldl.h

noinst_LTLIBRARIES = libldli.la libldll.la
libldli_la_SOURCES = $(LDLSRC)
libldll_la_SOURCES = $(LDLSRC)
libldll_la_CPPFLAGS = $(AM_CPPFLAGS) -DLDL_LONG

lib_LTLIBRARIES = libldl.la
libldl_la_SOURCES =
libldl_la_LIBADD = libldll.la libldli.la @SUITESPARSECONFIG_LIBS@

MAINTAINERCLEANFILES = Makefile.in
