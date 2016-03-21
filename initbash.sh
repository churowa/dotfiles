#!/usr/bin/env bash

cd ~/.dotfiles/term
mkdir -p ~/backup-bash-delete-when-ok

FILES=*
for f in $FILES
do
  echo "Processing $f file..."
  if [ -f ~/.$f ]
    then
      mv ~/.$f ~/backupbash-delete-when-ok/$f
  fi

  ln -s ~/.dotfiles/term/$f ~/.$f
  echo ""
done

cd -
