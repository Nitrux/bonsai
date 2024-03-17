#!/usr/bin/env bash

BONSAI_VERSION=$([ -z $BRANCH_BONSAI ] && echo "v1.1.3" || echo $BRANCH_BONSAI)

echo "Cloning Bonsai from branch/tag $BONSAI_VERSION"

git clone --depth 1 --branch $BONSAI_VERSION https://invent.kde.org/maui/bonsai.git

cd bonsai
cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr"

make -j$(nproc)
make install