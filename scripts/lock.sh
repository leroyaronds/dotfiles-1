#!/bin/bash
#
TMP_BG=/tmp/screenshot.png
#
# Take screenshot
scrot $TMP_BG
# Pixelate screenshot
convert $TMP_BG -scale 10% -scale 1000% $TMP_BG
# Start screen locker
i3lock -i $TMP_BG -f -n
