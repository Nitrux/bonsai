#!/usr/bin/env bash

BONSAI_VERSION=$([ -z $BRANCH_BONSAI ] && echo "master" || echo $BRANCH_BONSAI)

echo "Cloning Bonsai from branch $BONSAI_VERSION"

git clone https://invent.kde.org/maui/bonsai.git --depth=1 -b $BONSAI_VERSION

cd bonsai
cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr"

make -j$(nproc)
make install