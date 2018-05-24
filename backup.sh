#!/bin/sh
tar -czC ~/ .gnupg .password-store | gpg --yes --cipher-algo AES256 -co ~/docs/im.b
