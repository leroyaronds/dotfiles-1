#!/bin/bash
#
FILENAME=$1
RECIPIENT=$2
#
gpg --output $FILENAME.gpg --encrypt --recipient $RECIPIENT $FILENAME
