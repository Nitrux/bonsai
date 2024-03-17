#!/usr/bin/env bash

MAUIKIT_FILEBROWSING_VERSION=$([ -z $BRANCH_MAUIKIT_FILEBROWSING ] && echo "v3.1.0" || echo $BRANCH_MAUIKIT_FILEBROWSING)

echo "Cloning Mauikit FileBrowsing from branch $MAUIKIT_FILEBROWSING_VERSION"

git clone --depth 1 --branch $MAUIKIT_FILEBROWSING_VERSION https://invent.kde.org/maui/mauikit-filebrowsing.git

cd mauikit-filebrowsing
mkdir -p build
cd build

cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    ..

make -j$(nproc)
DESTDIR=/ make install
make install