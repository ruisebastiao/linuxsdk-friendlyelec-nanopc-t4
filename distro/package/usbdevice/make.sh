#!/bin/bash

set -e
install -m 755 -D $TOP_DIR/buildroot/package/rockchip/usbdevice/S50usbdevice $TARGET_DIR/etc/init.d/
install -m 644 -D $TOP_DIR/buildroot/package/rockchip/usbdevice/61-usbdevice.rules $TARGET_DIR/lib/udev/rules.d/
install -m 755 -D $TOP_DIR/buildroot/package/rockchip/usbdevice/usbdevice $TARGET_DIR/usr/bin/
