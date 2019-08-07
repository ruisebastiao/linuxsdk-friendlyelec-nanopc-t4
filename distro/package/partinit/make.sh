#!/bin/bash

set -e
source $TOP_DIR/device/rockchip/.BoardConfig.mk
install -m 0755 $BUILDROOT_PKG_DIR/rockchip/partinit/S21mountall.sh $TARGET_DIR/etc/init.d/
install -m 0755 $BUILDROOT_PKG_DIR/rockchip/partinit/fstab $TARGET_DIR/etc/
install -m 0644 $BUILDROOT_PKG_DIR/rockchip/partinit/61-partition-init.rules $TARGET_DIR/lib/udev/rules.d/
install -m 0644 $BUILDROOT_PKG_DIR/rockchip/partinit/61-sd-cards-auto-mount.rules $TARGET_DIR/lib/udev/rules.d/
echo -e "/dev/disk/by-partlabel/oem\t/oem\t\t\t$RK_OEM_FS_TYPE\t\tdefaults\t\t0\t2" >> $TARGET_DIR/etc/fstab
echo -e "/dev/disk/by-partlabel/userdata\t/userdata\t\t$RK_USERDATA_FS_TYPE\t\tdefaults\t\t0\t2" >> $TARGET_DIR/etc/fstab

mkdir -p $TARGET_DIR/oem $TARGET_DIR/userdata $TARGET_DIR/mnt/sdcard
cd $TARGET_DIR/
ln -fs userdata data
ln -fs mnt/sdcard sdcard
cd -
