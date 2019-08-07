#!/bin/bash

set -e

PKG=gst-plugins-good-1.14.4
if [ ! -e $DOWNLOAD_DIR/$PKG.tar.xz ];then
	wget -P $DOWNLOAD_DIR https://gstreamer.freedesktop.org/src/gst-plugins-good/$PKG.tar.xz
fi

if [ ! -d $BUILD_DIR/$PKG ];then
	tar -xf $DOWNLOAD_DIR/$PKG.tar.xz -C $BUILD_DIR
fi

cd $BUILD_DIR/$PKG
./configure --target=aarch64-linux-gnu --host=aarch64-linux-gnu --prefix=/usr --libdir=/usr/lib/$TOOLCHAIN --disable-gtk-doc --disable-gtk-doc-html --disable-dependency-tracking --disable-nls --disable-static --enable-shared  --disable-valgrind --disable-examples --disable-directsound --disable-waveform --disable-osx_audio --disable-osx_video --disable-aalib --disable-aalibtest --disable-libcaca --disable-qt --disable-libdv --disable-dv1394 --disable-shout2 --disable-jack --with-libv4l2 --enable-alpha --enable-apetag --disable-audiofx --enable-audioparsers --enable-auparse --enable-autodetect --enable-avi --disable-cutter --disable-debugutils --disable-deinterlace --disable-dtmf --disable-effectv --disable-equalizer --enable-flv --disable-flx --disable-goom --disable-goom2k1 --disable-icydemux --enable-id3demux --disable-imagefreeze --disable-interleave --enable-isomp4 --disable-lame --disable-mpg123 --disable-law --disable-level --enable-matroska --disable-monoscope --enable-multifile --disable-multipart --disable-replaygain --enable-rtp --enable-rtpmanager --enable-rtsp --disable-shapewipe --disable-smpte --disable-spectrum --disable-udp --enable-videobox --enable-videocrop --enable-videofilter --enable-videomixer --disable-wavenc --enable-wavparse --disable-y4m --disable-oss --disable-oss4 --enable-gst_v4l2 --disable-v4l2-probe --disable-x --disable-cairo --disable-flac --disable-gdk_pixbuf --enable-jpeg --enable-libpng --disable-pulse --disable-soup --disable-speex --disable-taglib --disable-vpx --disable-wavpack --disable-zlib --disable-bz2
make
make install
$SCRIPTS_DIR/fixlibtool.sh $TARGET_DIR $TARGET_DIR
cd -
