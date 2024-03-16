#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    APT_COMMAND="sudo apt-get"
else
    APT_COMMAND="apt-get"
fi

$APT_COMMAND update -q

# Common build dependencies.
$APT_COMMAND install -qy --no-install-recommends \
    appstream \
    automake \
    autotools-dev \
    build-essential \
    checkinstall \
    cmake \
    curl \
    devscripts \
    equivs \
    extra-cmake-modules \
    gettext \
    git \
    gnupg2 \
    libwayland-dev \
    lintian

# Common Qt build headers.
$APT_COMMAND install -qy --no-install-recommends \
    libqt5svg5-dev \
    libqt5x11extras5-dev \
    qtbase5-dev \
    qtdeclarative5-dev \
    qtquickcontrols2-5-dev \
    qtquickcontrols2-5-dev \
    qtwayland5 \
    qtwayland5-dev-tools \
    qtwayland5-private-dev

# Common KF5 headers.
    libkf5i18n-dev \
    libkf5coreaddons-dev

# Build dependencies for MauiMan.
$APT_COMMAND install -qy --no-install-recommends \
    qtsystems5-dev

# Build dependencies for MauiKit.
$APT_COMMAND install -qy --no-install-recommends \
    libkf5solid-dev \
    libxcb-icccm4-dev \
    libxcb-shape0-dev \
    nlohmann-json3-dev \
    qml-module-qtgraphicaleffects \
    qml-module-qtquick-controls2 \
    qml-module-qtquick-shapes

# Build dependencies for MauiKit FileBrowsing.
$APT_COMMAND install -qy --no-install-recommends \
    libkf5kio-dev

# Build dependencies for MauiKit Terminal.
$APT_COMMAND install -qy --no-install-recommends \
    libkf5config-dev \
    libkf5pty-dev \
    libkf5notifications-dev \
    libkf5service-dev 

# Build dependencies for MauiKit TextEditor.
$APT_COMMAND install -qy --no-install-recommends \
    libkf5syntaxhighlighting-dev 

# Build dependencies for Bonsai.
$APT_COMMAND install -qy --no-install-recommends \
    libgit2-dev
