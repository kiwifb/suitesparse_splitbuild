NVCC = @NVCC@

AM_CPPFLAGS = -I$(top_srcdir)/Include @SUITESPARSECONFIG_CFLAGS@

noinst_LTLIBRARIES = libcholmod_gpu.la libcholmodi_gpu.la libcholmodl_gpu.la
noinst_HEADERS = t_cholmod_gpu.c

libcholmodi_gpu_la_SOURCES = cholmod_gpu.c

libcholmodl_gpu_la_SOURCES = $(libcholmodi_gpu_la_SOURCES)
libcholmodl_gpu_la_CPPFLAGS = $(AM_CPPFLAGS) -DDLONG

libcholmod_gpu_la_SOURCES = cholmod_gpu_kernels.cu
libcholmod_gpu_la_LIBADD = libcholmodi_gpu.la libcholmodl_gpu.la

.cu.lo:
	$(LIBTOOL) --tag=CC --mode=compile $(NVCC) -c $<
