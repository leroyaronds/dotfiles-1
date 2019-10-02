# Server
#
# Run as git user
git init --bare ~/.password-store
# Import authorized public SSH keys

# Client
#
# Create local password store
pass init <gpg key id>
# Enable management of local changes through Git
pass git init
# Add the the remote git repository as 'origin'
pass git remote add origin ssh://git@jill.com:4242/~/.password-store
# Push your local Pass history
pass git push -u --all
