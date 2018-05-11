#!/bin/sh
#
echo "Deploying dotfiles to ${HOME}"
# Make symlinks
FILES=$(find $(pwd) -maxdepth 1 -type f -name ".*" -not -name "*.swp")
for FILE in $FILES
do
	F=$(basename $FILE);
	ln -sn $FILE ${HOME}/${F};
done

ln -sn $(pwd)/.config ${HOME}/.config
