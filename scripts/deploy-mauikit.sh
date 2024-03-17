#!/usr/bin/env bash

MAUIKIT_VERSION=$([ -z $BRANCH_MAUIKIT ] && echo "v3.1.0" || echo $BRANCH_MAUIKIT)

echo "Cloning Mauikit from branch $MAUIKIT_VERSION"

git clone --depth 1 --branch $MAUIKIT_VERSION https://invent.kde.org/maui/mauikit.git

cd mauikit
cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    .

make -j$(nproc)
DESTDIR=/ make install
make install