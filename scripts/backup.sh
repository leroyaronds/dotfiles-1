#!/bin/sh
tar -czC ~/ .gnupg | gpg --yes --cipher-algo AES256 -co ~/docs/thumbs.db
#
notify-send -a "Backup.sh" -u normal "Backup" "Backup was done and successfull"
