#!/bin/bash

set -e
CONFIG_FILE=$TARGET_DIR/etc/init.d/.usb_config

if [ ! -e $CONFIG_FILE ];then
	touch $CONFIG_FILE
fi

if [ ! `grep usb_adb_en $CONFIG_FILE` ];then
	echo usb_adb_en >> $CONFIG_FILE
fi

