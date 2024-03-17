#!/usr/bin/env bash

MAUIMAN_VERSION=$([ -z $BRANCH_MAUIMAN ] && echo "v3.1.0" || echo $BRANCH_MAUIMAN)

echo "Cloning Mauiman from branch $MAUIMAN_VERSION"

git clone --depth 1 --branch $MAUIMAN_VERSION https://invent.kde.org/maui/mauiman.git

cd mauiman
cmake -DCMAKE_BUILD_TYPE="Release" \
    -DCMAKE_INSTALL_PREFIX="/usr" \
    -DBUNDLE_MAUI_STYLE=ON \
    .

make -j$(nproc)
DESTDIR=/ make install
make install