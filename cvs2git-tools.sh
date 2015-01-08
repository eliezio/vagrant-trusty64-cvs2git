#!/usr/bin/env bash

set -e -x

if [ ! -x /usr/local/bin/cvs-fast-export ]; then
	if [ ! -d cvs-fast-export ]; then
		git clone --branch 1.29 --depth 1 https://gitorious.org/cvs-fast-export/cvs-fast-export.git
		pushd cvs-fast-export
		sudo make install-bin
		popd
	fi
fi

if [ ! -x /usr/local/bin/l1u8recode ]; then
	if [ ! -d latin1-to-utf8 ]; then
		git clone --branch v1.0.0 --depth 1 https://github.com/eliezio/latin1-to-utf8.git
	fi
	pushd latin1-to-utf8
	mkdir -p Release
	cd Release
	cmake -DCMAKE_BUILD_TYPE=Release ..
	make
	ctest
	sudo make install
	popd
fi

