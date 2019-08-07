#!/bin/bash

set -e
install -m 0644 -D $TOP_DIR/external/alsa-config/cards/* $TARGET_DIR/usr/share/alsa/cards/
