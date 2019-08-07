#!/bin/bash

set -e

PKG=gstreamer-1.14.4
if [ ! -e $DOWNLOAD_DIR/$PKG.tar.xz ];then
	wget -P $DOWNLOAD_DIR https://gstreamer.freedesktop.org/src/gstreamer/$PKG.tar.xz
fi

if [ ! -d $BUILD_DIR/$PKG ];then
	tar -xf $DOWNLOAD_DIR/$PKG.tar.xz -C $BUILD_DIR
fi

cd $BUILD_DIR/$PKG
./configure --target=aarch64-linux-gnu --host=aarch64-linux-gnu --prefix=/usr --libdir=/usr/lib/$TOOLCHAIN --disable-gtk-doc --disable-gtk-doc-html --disable-dependency-tracking --disable-nls --disable-static --enable-shared  --disable-examples --disable-tests --disable-failing-tests --disable-valgrind --disable-benchmarks --disable-introspection --disable-check
make
make install
$SCRIPTS_DIR/fixlibtool.sh $TARGET_DIR $TARGET_DIR
#sed -i 's/[^ ]*libgstreamer-1.0.la//' $TARGET_DIR/usr/lib/$TOOLCHAIN/libgstbase-1.0.la
cd -
cd $TARGET_DIR/usr/bin
ln -sf $TOOLCHAIN-gst-device-monitor-1.0 gst-device-monitor-1.0
ln -sf $TOOLCHAIN-gst-discoverer-1.0 gst-discoverer-1.0
ln -sf $TOOLCHAIN-gst-inspect-1.0 gst-inspect-1.0
ln -sf $TOOLCHAIN-gst-launch-1.0 gst-launch-1.0
ln -sf $TOOLCHAIN-gst-play-1.0 gst-play-1.0
ln -sf $TOOLCHAIN-gst-stats-1.0 gst-stats-1.0
ln -sf $TOOLCHAIN-gst-typefind-1.0 gst-typefind-1.0
cd -
