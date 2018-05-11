#!/bin/sh
#
echo "Deploying dotfiles to ${HOME} :\n"
# Make symlinks
FILES=$(find $(pwd) -maxdepth 1 -name ".*" -not -name ".git")
for FILE in $FILES
do
	F=$(basename $FILE);
	echo ".. ${F}"
	ln -sn $FILE ${HOME}/${F};
done
