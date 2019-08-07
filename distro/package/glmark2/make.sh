#!/bin/bash

set -e
COMMIT=9a03892d0ef250b0eb5c87792dbfbd48e23d15bb
PKG=glmark2-$COMMIT
if [ ! -e $DOWNLOAD_DIR/$PKG.tar.gz ];then
	wget -O $DOWNLOAD_DIR/$PKG.tar.gz https://github.com/glmark2/glmark2/archive/$COMMIT/$PKG.tar.gz
fi

if [ ! -d $BUILD_DIR/$PKG ];then
	tar -xzf $DOWNLOAD_DIR/$PKG.tar.gz -C $BUILD_DIR
fi

cd $BUILD_DIR/$PKG
./waf configure --with-flavors=drm-glesv2,wayland-glesv2 --prefix=/usr
./waf
./waf install
cd -
