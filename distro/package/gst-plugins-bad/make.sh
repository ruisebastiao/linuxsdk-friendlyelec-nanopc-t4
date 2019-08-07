#!/bin/bash

set -e

PKG=gst-plugins-bad-1.14.4
if [ ! -e $DOWNLOAD_DIR/$PKG.tar.xz ];then
	wget -P $DOWNLOAD_DIR https://gstreamer.freedesktop.org/src/gst-plugins-bad/$PKG.tar.xz
fi

if [ ! -d $BUILD_DIR/$PKG ];then
	tar -xf $DOWNLOAD_DIR/$PKG.tar.xz -C $BUILD_DIR
fi

cd $BUILD_DIR/$PKG
./configure --target=aarch64-linux-gnu --host=aarch64-linux-gnu --prefix=/usr --libdir=/usr/lib/$TOOLCHAIN --disable-gtk-doc --disable-gtk-doc-html --disable-dependency-tracking --disable-nls --disable-static --enable-shared  --disable-examples --disable-valgrind --disable-directsound --disable-direct3d --disable-winks --disable-android_media --disable-apple_media --disable-acm --disable-introspection --disable-avc --disable-opensles --disable-uvch264 --disable-msdk --disable-voamrwbenc --disable-bs2b --disable-chromaprint --disable-dc1394 --disable-dts --disable-resindvd --disable-faac --disable-flite --disable-gsm --disable-fluidsynth --disable-kate --disable-ladspa --disable-lv2 --disable-libde265 --disable-modplug --disable-mplex --disable-ofa --disable-openexr --disable-openni2 --disable-teletextdec --disable-wildmidi --disable-smoothstreaming --disable-soundtouch --disable-spc --disable-gme --disable-vdpau --disable-schro --disable-zbar --disable-spandsp --disable-gtk3 --enable-wayland --disable-bluez --disable-accurip --disable-adpcmdec --disable-adpcmenc --disable-aiff --disable-asfmux --disable-audiobuffersplit --disable-audiofxbad --disable-audiomixmatrix --disable-compositor --disable-audiovisualizers --disable-autoconvert --disable-bayer --enable-camerabin2 --disable-coloreffects --enable-debugutils --disable-dvbsuboverlay --disable-dvdspu --disable-faceoverlay --disable-festival --disable-fieldanalysis --disable-freeverb --disable-frei0r --disable-gaudieffects --disable-geometrictransform --disable-gdp --disable-id3tag --disable-inter --disable-interlace --disable-ivfparse --disable-ivtc --disable-jp2kdecimator --disable-jpegformat --disable-librfb --disable-midi --enable-mpegdemux --enable-mpegtsdemux --enable-mpegtsmux --enable-mpegpsmux --disable-mxf --disable-netsim --disable-onvif --disable-pcapparse --disable-pnm --disable-rawparse --disable-removesilence --disable-rtmp --disable-sdp --disable-segmentclip --disable-siren --disable-smooth --disable-speed --disable-subenc --disable-stereo --disable-timecode --disable-videofilters --disable-videoframe_audiolevel --disable-iqa --enable-videoparsers --disable-videosignal --disable-vmnc --disable-y4m --disable-yadif --disable-assrender --disable-bz2 --disable-curl --disable-dash --disable-decklink --disable-directfb --disable-dvb --disable-faad --disable-fbdev --disable-fdk_aac --disable-gl --disable-hls --enable-kms --disable-libmms --disable-dtls --disable-ttml --disable-mpeg2enc --disable-musepack --disable-neon --disable-openal --disable-opencv --disable-openh264 --disable-openjpeg --disable-opus --disable-rsvg --disable-sbc --disable-shm --disable-sndfile --disable-srtp --disable-vcd --disable-voaacenc --disable-webp --disable-webrtcdsp --disable-x265
make
make install
$SCRIPTS_DIR/fixlibtool.sh $TARGET_DIR $TARGET_DIR
cd -
