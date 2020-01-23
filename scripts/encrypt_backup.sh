#!/bin/bash
#
DIRECTORY=$1
RECIPIENT=$2
#
tar -czC ~/ $DIRECTORY | gpg --output ~/$DIRECTORY.gpg --encrypt --recipient $RECIPIENT
