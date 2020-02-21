#!/bin/bash
#

# Import PUBLIC keys
gpg --import pgp-public-keys.asc

# Import PRIVATE keys
gpg --import pgp-private-keys.asc

# Import TRUST
gpg --import-ownertrust pgp-ownertrust.asc
