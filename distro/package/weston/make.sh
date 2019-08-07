#!/bin/bash

set -e
PKG=weston-5.0.0

if [ ! -e $DOWNLOAD_DIR/$PKG.tar.gz ];then
        wget -O $DOWNLOAD_DIR/$PKG.tar.gz https://github.com/wayland-project/weston/archive/5.0.0.tar.gz
fi

if [ ! -d $BUILD_DIR/$PKG ];then
        tar -xzf $DOWNLOAD_DIR/$PKG.tar.gz -C $BUILD_DIR
fi
sed -i 's/^Version.*/Version: 17/g' $TARGET_DIR/usr/lib/$TOOLCHAIN/pkgconfig/gbm.pc
cd $BUILD_DIR/$PKG
./autogen.sh --target=aarch64-linux-gnu --host=aarch64-linux-gnu --prefix=/usr --libdir=/usr/lib/$TOOLCHAIN --disable-dependency-tracking --disable-static --enable-shared  --disable-headless-compositor --disable-colord --disable-devdocs --disable-setuid-install --enable-dbus --enable-weston-launch --enable-egl --disable-rdp-compositor --disable-fbdev-compositor --enable-drm-compositor WESTON_NATIVE_BACKEND=drm-backend.so --disable-x11-compositor --disable-xwayland --disable-vaapi-recorder --disable-lcms --disable-systemd-login --disable-systemd-notify --enable-junit-xml --disable-demo-clients-install
make WAYLAND_PROTOCOLS_DATADIR=$TARGET_DIR/usr/share/wayland-protocols
make install
cd -

