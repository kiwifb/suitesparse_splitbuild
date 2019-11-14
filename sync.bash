#!/bin/bash

# sync with upstream
wget -nc -c https://github.com/DrTimothyAldenDavis/SuiteSparse/archive/v$1.tar.gz -O SuiteSparse-$1.tar.gz

# sync m4 macros
for macro in ax_blas ax_lapack; do
    wget http://git.savannah.gnu.org/cgit/autoconf-archive.git/plain/m4/${macro}.m4 -O addons/m4/${macro}.m4
done

tar xf SuiteSparse-$1.tar.gz
