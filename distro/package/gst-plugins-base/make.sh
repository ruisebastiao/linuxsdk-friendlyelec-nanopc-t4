#!/bin/bash

set -e

PKG=gst-plugins-base-1.14.4
if [ ! -e $DOWNLOAD_DIR/$PKG.tar.xz ];then
	wget -P $DOWNLOAD_DIR https://gstreamer.freedesktop.org/src/gst-plugins-base/$PKG.tar.xz
fi

if [ ! -d $BUILD_DIR/$PKG ];then
	tar -xf $DOWNLOAD_DIR/$PKG.tar.xz -C $BUILD_DIR
fi

cd $BUILD_DIR/$PKG
./configure --target=aarch64-linux-gnu --host=aarch64-linux-gnu --prefix=/usr --libdir=/usr/lib/$TOOLCHAIN --disable-gtk-doc --disable-gtk-doc-html --disable-dependency-tracking --disable-nls --disable-static --enable-shared  --disable-examples --disable-valgrind --disable-introspection --disable-cdparanoia --disable-libvisual --disable-iso-codes --disable-opengl --disable-gles2 --disable-glx --disable-egl --disable-x11 --disable-wayland --disable-dispmanx --disable-adder --enable-app --enable-audioconvert --disable-audiomixer --enable-audiorate --enable-audiotestsrc --enable-encoding --enable-videoconvert --disable-gio --enable-playback --enable-audioresample --disable-rawparse --disable-subparse --disable-tcp --enable-typefind --enable-videotestsrc --enable-videorate --enable-videoscale --enable-volume --disable-x --disable-xshm --disable-xvideo --disable-ivorbis --disable-opus --enable-ogg --disable-pango --enable-theora --enable-vorbis
make
make install
$SCRIPTS_DIR/fixlibtool.sh $TARGET_DIR $TARGET_DIR
cd -
