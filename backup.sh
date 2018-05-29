#!/bin/sh
tar -czC ~/ .gnupg | gpg --yes --cipher-algo AES256 -co ~/docs/im.b
#
notify-send -a "Backup.sh" -u normal "Backup success" "Backup was done and successfull"
