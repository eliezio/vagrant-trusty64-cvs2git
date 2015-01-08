#!/usr/bin/env bash

set -x

sudo apt-get -qq update

REQUIRED_PKGS="git bison flex cmake wget bsdtar g++"

# Check for missing packages
MISSING_PKGS=""
for pkg in $REQUIRED_PKGS; do
    if ! dpkg -s $pkg &> /dev/null; then
        MISSING_PKGS="$MISSING_PKGS $pkg"
    fi
done

if [ "$MISSING_PKGS" ]; then
    sudo apt-get install -y $MISSING_PKGS 2> /dev/null
fi

# Google Test

GTEST_VERSION=1.7.0
GTEST_URL=https://googletest.googlecode.com/files/gtest-${GTEST_VERSION}.zip

if [ ! -x /usr/local/src/gtest-${GTEST_VERSION} ]; then
    wget -qO- $GTEST_URL | bsdtar -xvf - -C /usr/local/src --no-same-owner --no-same-permissions
fi
if [ ! -r /etc/profile.d/gtest.sh ]; then
    cat > /etc/profile.d/gtest.sh <<EOF
export GTEST_ROOT=/usr/local/src/gtest-${GTEST_VERSION}
EOF
fi
