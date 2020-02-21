#!/bin/bash
#

# Export PUBLIC keys
gpg --armor --export > pgp-public-keys.asc

# Export PRIVATE keys
gpg --armor --export-secret-keys > pgp-private-keys.asc

# Export PRIVATE SUB keys
gpg --armor --export-secret-subkeys > pgp-private-subkeys.asc

# Export TRUST
gpg --export-ownertrust > pgp-ownertrust.asc

# Create revocation token
#gpg --armor --gen-revoke $KEYID > pgp-revocation.asc

# Upload public key to server
#gpg --keyserver keys.openpgp.org --send-keys $KEYID
