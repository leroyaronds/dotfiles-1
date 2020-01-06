#!/bin/bash
#
# Install 'zbar' package
#
FILENAME=$1
#
zbarimg -q --raw $FILENAME

