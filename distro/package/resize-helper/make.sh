#!/bin/bash

set -e

install -m 0755 -D $PACKAGE_DIR/resize-helper/resize-helper $TARGET_DIR/usr/sbin/resize-helper
install -m 0755 -D $PACKAGE_DIR/resize-helper/S22resize-disk $TARGET_DIR/etc/init.d/
