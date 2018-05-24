#!/bin/sh
tar -C ~/ -cz Backup | gpg --yes --cipher-algo AES256 -co ~/docs/image.b
