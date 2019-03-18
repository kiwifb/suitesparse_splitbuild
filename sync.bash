#!/bin/bash

# sync with upstream
wget -nc -c http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-5.4.0.tar.gz

# sync m4 macros
for macro in ax_blas ax_lapack; do
    wget http://git.savannah.gnu.org/cgit/autoconf-archive.git/plain/m4/${macro}.m4 -O addons/m4/${macro}.m4
done

tar xf SuiteSparse-5.4.0.tar.gz
