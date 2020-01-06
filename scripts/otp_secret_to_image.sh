#!/bin/bash
#
# Install 'qrencode'
#
SECRET=$1
#
qrencode -t ansiutf8 $SECRET

