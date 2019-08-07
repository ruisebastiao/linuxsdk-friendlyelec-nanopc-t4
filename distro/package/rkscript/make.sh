#!/bin/bash

set -e
	
install -m 0755 -D $TOP_DIR/buildroot/package/rockchip/rkscript/*.sh $TARGET_DIR/usr/bin/
