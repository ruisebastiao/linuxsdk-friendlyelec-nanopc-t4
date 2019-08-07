#!/bin/bash

set -e

PKG=gst-plugins-ugly-1.14.4
if [ ! -e $DOWNLOAD_DIR/$PKG.tar.xz ];then
	wget -P $DOWNLOAD_DIR https://gstreamer.freedesktop.org/src/gst-plugins-ugly/$PKG.tar.xz
fi

if [ ! -d $BUILD_DIR/$PKG ];then
	tar -xf $DOWNLOAD_DIR/$PKG.tar.xz -C $BUILD_DIR
fi

cd $BUILD_DIR/$PKG
./configure --target=aarch64-linux-gnu --host=aarch64-linux-gnu --prefix=/usr --libdir=/usr/lib/$TOOLCHAIN --disable-gtk-doc --disable-gtk-doc-html --disable-dependency-tracking --disable-nls --disable-static --enable-shared  --disable-examples --disable-valgrind --disable-a52dec --disable-amrnb --disable-amrwb --disable-cdio --disable-sidplay --disable-asfdemux --disable-dvdlpcmdec --disable-dvdsub --disable-xingmux --disable-realmedia --disable-dvdread --disable-mpeg2dec --disable-x264
make
make install
$SCRIPTS_DIR/fixlibtool.sh $TARGET_DIR $TARGET_DIR
cd -
