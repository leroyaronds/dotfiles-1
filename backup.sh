#!/bin/sh
tar -C ~/ -cz .gnupg .password-store | gpg --yes --cipher-algo AES256 -co ~/docs/im.b
