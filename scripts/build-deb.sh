#! /bin/bash

set -x

### Update sources

wget -qO /etc/apt/sources.list.d/nitrux-main-compat-repo.list https://raw.githubusercontent.com/Nitrux/iso-tool/development/configs/files/sources.list.nitrux

wget -qO /etc/apt/sources.list.d/nitrux-testing-repo.list https://raw.githubusercontent.com/Nitrux/iso-tool/development/configs/files/sources.list.nitrux.testing

DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys \
	55751E5D > /dev/null

curl -L https://packagecloud.io/nitrux/repo/gpgkey | apt-key add -;
curl -L https://packagecloud.io/nitrux/compat/gpgkey | apt-key add -;
curl -L https://packagecloud.io/nitrux/testing/gpgkey | apt-key add -;

DEBIAN_FRONTEND=noninteractive apt -qq update

### Install Package Build Dependencies #2

DEBIAN_FRONTEND=noninteractive apt -qq -yy install --no-install-recommends \
	mauikit-git \
	mauikit-filebrowsing-git

### Download Source

git clone --depth 1 --branch $BONSAI_BRANCH https://invent.kde.org/maui/bonsai.git


### FIX Bonsai .desktop launcher
### See bug https://invent.kde.org/maui/bonsai/-/issues/1

sed -i 's+MimeType=inode/directory;+MimeType=x-scheme-handler/x-github-client;x-scheme-handler/x-github-desktop-auth;x-scheme-handler/x-github-desktop-dev-auth;+g' bonsai/org.maui.bonsai.desktop


### Compile Source

mkdir -p build && cd build

cmake \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DENABLE_BSYMBOLICFUNCTIONS=OFF \
	-DQUICK_COMPILER=ON \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_SYSCONFDIR=/etc \
	-DCMAKE_INSTALL_LOCALSTATEDIR=/var \
	-DCMAKE_EXPORT_NO_PACKAGE_REGISTRY=ON \
	-DCMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY=ON \
	-DCMAKE_INSTALL_RUNSTATEDIR=/run "-GUnix Makefiles" \
	-DCMAKE_VERBOSE_MAKEFILE=ON \
	-DCMAKE_INSTALL_LIBDIR=lib/x86_64-linux-gnu ../bonsai/

make -j$(nproc)

### Run checkinstall and Build Debian Package

>> description-pak printf "%s\n" \
	'MauiKit Git repository manager.' \
	'' \
	'Bonsai is a Git repository manager.' \
	'' \
	'Bonsai works on desktops, Android and Plasma Mobile.' \
	'' \
	''

checkinstall -D -y \
	--install=no \
	--fstrans=yes \
	--pkgname=bonsai-git \
	--pkgversion=$PACKAGE_VERSION \
	--pkgarch=amd64 \
	--pkgrelease="1" \
	--pkglicense=LGPL-3 \
	--pkggroup=utils \
	--pkgsource=bonsai \
	--pakdir=. \
	--maintainer=probal31@gmail.com \
	--provides=bonsai \
	--requires="libc6,libgcc-s1,libgit2-28,libkf5coreaddons5,libkf5i18n5,libqt5core5a,libqt5gui5,libqt5qml5,libqt5quick5,libqt5widgets5,libstdc++6,mauikit-git \(\>= 2.2.0+git\),mauikit-filebrowsing-git \(\>= 2.2.0+git\)" \
	--nodoc \
	--strip=no \
	--stripso=yes \
	--reset-uids=yes \
	--deldesc=yes
