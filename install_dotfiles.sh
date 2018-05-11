#!/bin/sh
#
# Clone Oh-My-Zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh

echo "Deploying dotfiles to ${HOME}"
# Make symlinks
FILES=$(find $(pwd) -maxdepth 1 -type f -name ".*" -not -name "*.swp")
for FILE in $FILES
do
	F=$(basename $FILE);
	ln -sn $FILE ${HOME}/${F};
done

ln -sn $(pwd)/.config ${HOME}/.config
