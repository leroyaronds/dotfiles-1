#!/bin/sh
tar -C ~/ -cz .gnupg | gpg --yes --cipher-algo AES256 -co ~/docs/im.b
