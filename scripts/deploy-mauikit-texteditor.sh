#!/usr/bin/env bash

MAUIKIT_TEXTEDITOR_VERSION=$([ -z $BRANCH_MAUIKIT_TEXTEDITOR ] && echo "master" || echo $BRANCH_MAUIKIT_TEXTEDITOR)

echo "Cloning Mauikit TextEditor from branch $MAUIKIT_TEXTEDITOR_VERSION"

git clone https://invent.kde.org/maui/mauikit-texteditor.git --depth=1 -b $MAUIKIT_TEXTEDITOR_VERSION

cd mauikit-texteditor
mkdir -p build
cd build

cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    ..

make -j$(nproc)
DESTDIR=/ make install
make install