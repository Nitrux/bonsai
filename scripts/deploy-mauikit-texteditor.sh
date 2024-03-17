#!/usr/bin/env bash

MAUIKIT_TEXTEDITOR_VERSION=$([ -z $BRANCH_MAUIKIT_TEXTEDITOR ] && echo "v3.1.0" || echo $BRANCH_MAUIKIT_TEXTEDITOR)

echo "Cloning Mauikit TextEditor from branch $MAUIKIT_TEXTEDITOR_VERSION"

git clone --depth 1 --branch $MAUIKIT_TEXTEDITOR_VERSION https://invent.kde.org/maui/mauikit-texteditor.git

cd mauikit-texteditor
mkdir -p build
cd build

cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    ..

make -j$(nproc)
DESTDIR=/ make install
make install