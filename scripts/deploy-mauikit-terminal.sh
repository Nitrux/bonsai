#!/usr/bin/env bash

MAUIKIT_TERMINAL_VERSION=$([ -z $BRANCH_MAUIKIT_TERMINAL ] && echo "3.1" || echo $BRANCH_MAUIKIT_TERMINAL)

echo "Cloning Mauikit Terminal from branch/tag $MAUIKIT_TERMINAL_VERSION"

git clone --depth 1 --branch  $MAUIKIT_TERMINAL_VERSION https://invent.kde.org/maui/mauikit-terminal.git

cd mauikit-terminal
mkdir -p build
cd build

cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    ..

make -j$(nproc)
DESTDIR=/ make install
make install