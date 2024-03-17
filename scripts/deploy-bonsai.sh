#!/usr/bin/env bash

BONSAI_VERSION=$([ -z $BRANCH_BONSAI ] && echo "3.1.0" || echo $BRANCH_BONSAI)

echo "Cloning Bonsai from branch/tag $BONSAI_VERSION"

git clone --depth 1 --branch https://invent.kde.org/maui/bonsai.git $BONSAI_VERSION

cd bonsai
cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr"

make -j$(nproc)
make install