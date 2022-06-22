#!/bin/bash

if [ $# -lt 1 ]; then
    echo $"Usage: $(basename $0) PKG
 Available SuiteSparse PKG:
  * ALL (build all packages)
$(ls -1d addons/* | xargs -n1 basename | grep -v '^\(config\|m4\)' | awk '{print "  * "$1}')"
    exit
fi

VERSION="5.12.0"

build_suitesparse_pkg() {
    local lib=$1 i
    shift
    # remove old
    if [[ -d SuiteSparse-${VERSION} ]];  then
	chmod -R 755 SuiteSparse-${VERSION}
	rm -rf SuiteSparse-${VERSION}
    fi
    # remove older unversionned version if present
    if [[ -d SuiteSparse ]];  then
	chmod -R 755 SuiteSparse
	rm -rf SuiteSparse
    fi
    rm -rf ${lib}_build
    tar xf SuiteSparse-${VERSION}.tar.gz

    # try to guess version
    # Also collect so_version as defined by suitesparse
    pushd SuiteSparse-${VERSION}/${lib} > /dev/null
    if [ -e Lib/Makefile ]; then
	version=$(awk '{ if ($1 == "VERSION" ) print $3}' Lib/Makefile )
	so_version=$(awk '{ if ($1 == "SO_VERSION" ) print $3}' Lib/Makefile )
    else
	# suitesparse_config doesn't have a Lib folder
	version=$(awk '{ if ($1 == "VERSION" ) print $3}' Makefile )
	so_version=$(awk '{ if ($1 == "SO_VERSION" ) print $3}' Makefile )
    fi
    # if required version number are not found previously try another way of guessing
    # via Changelog
    if [ -z $version ]; then
        version=$(head -2 Doc/ChangeLog | awk '{ if ($4 == "version" ) print $5}')
    fi
    # if so_version is not found set it to 0
    if [ -z $so_version ]; then
        so_version=0
    fi
    popd > /dev/null
    echo "Doing ${lib} ${version} with so_version ${so_version}"

    # backup all Makefile's
    for i in $(find SuiteSparse-${VERSION}/${lib} -name Makefile); do
	[ -e ${i}.orig ] || mv ${i} ${i}.orig
    done

    # copy common files
    cp -r addons/{config,m4} SuiteSparse-${VERSION}/${lib}

    # copy specific files
    for i in $(find addons/${lib} -type f); do
	cp ${i} SuiteSparse-${VERSION}/$(dirname ${i/addons\/})
    done

    pushd SuiteSparse-${VERSION}/${lib} > /dev/null
    # apply hook
    [[ -x post-copy-hook.bash ]] && ./post-copy-hook.bash
    sed -e "/AC_INIT/ s|[[:digit:]]\.[[:digit:]]\.[[:digit:]]|${version}|" \
        -e "s:@SO_NAME@:${so_version}:" \
        -i configure.ac
    # configure, build, test, and package
    autoreconf -vi && \
	PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:$PKG_CONFIG_PATH" \
	./configure && make distcheck PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:$PKG_CONFIG_PATH"

    # cleanup
    if [[ $? -eq 0 ]]; then
	make maintainer-clean
	[[ -x post-install-hook.bash ]] && ./post-install-hook.bash
	rm -rf config m4 configure.ac *.pc.in post-*.bash
	find . -name Makefile.am -delete
	for i in $(find . -name Makefile.orig); do
	    mv ${i} ${i/.orig/}
	done
    else
	popd > /dev/null
	echo "!! FAILED - See above"
	exit 1
    fi
    popd > /dev/null

    # now install and save generated tar ball
    local tb=$(find SuiteSparse-${VERSION}/${lib} -name \*-${version}.tar.bz2)
    local src=$(basename ${tb} .tar.bz2)
    tar xf ${tb} && \
	mkdir ${lib}_build && \
	pushd ${lib}_build && \
	PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig:$PKG_CONFIG_PATH" \
	../${src}/configure --prefix=${PREFIX} --disable-static $@ && \
	make install && \
	popd && \
	rm -rf ${lib}_build ${src} && \
	mkdir -p distfiles && mv ${tb} distfiles/ && \
	echo "Successfully built ${tb} now in distfiles"
}

PREFIX=${PWD}/usr

[[ -e "SuiteSparse-${VERSION}.tar.gz" ]] || ./sync.bash ${VERSION}

[[ -d "SuiteSparse-${VERSION}" ]] || tar xf SuiteSparse-${VERSION}.tar.gz

if [[ $1 == ALL ]]; then
    # need to keep an order for dependencies
    build_suitesparse_pkg SuiteSparse_config
    build_suitesparse_pkg AMD
    build_suitesparse_pkg COLAMD
    build_suitesparse_pkg CAMD
    build_suitesparse_pkg CCOLAMD
    build_suitesparse_pkg CSparse
    build_suitesparse_pkg CXSparse
    build_suitesparse_pkg RBio
    build_suitesparse_pkg LDL
    build_suitesparse_pkg BTF
    build_suitesparse_pkg CHOLMOD --with-partition
    build_suitesparse_pkg KLU
    build_suitesparse_pkg SPQR --with-partition
    build_suitesparse_pkg UMFPACK
else
    build_suitesparse_pkg $1
fi
