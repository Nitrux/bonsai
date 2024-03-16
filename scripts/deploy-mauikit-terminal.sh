#!/usr/bin/env bash

MAUIKIT_TERMINAL_VERSION=$([ -z $BRANCH_MAUIKIT_TERMINAL ] && echo "master" || echo $BRANCH_MAUIKIT_TERMINAL)

echo "Cloning Mauikit Terminal from branch $MAUIKIT_TERMINAL_VERSION"

git clone https://invent.kde.org/maui/mauikit-terminal.git --depth=1 -b $MAUIKIT_TERMINAL_VERSION

cd mauikit-terminal
mkdir -p build
cd build

cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    ..

make -j$(nproc)
DESTDIR=/ make install
make install