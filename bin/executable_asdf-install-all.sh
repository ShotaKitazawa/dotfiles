#!/bin/bash

# requirements: https://github.com/mikefarah/yq v4.0.0+

set -u
_echo () {
  echo $@
}

_file=$1

# create $HOME/bin
if [ ! -e $HOME/bin ]; then mkdir $HOME/bin; fi

# install asdf
if [ ! -e $HOME/.asdf ]; then git clone https://github.com/asdf-vm/asdf.git -b ${ASDF_VERSION} $HOME/.asdf; fi

# install each packages in asdf
_asdf="$HOME/.asdf/bin/asdf"
_asdf_shims="$HOME/.asdf/shims"
for i in $(seq 0 $(( $(yq ". | length" $_file) - 1 ))); do
  _echo "-> install $(yq ".[$i].name" $_file) $(yq ".[$i].version" $_file)"
  $_asdf plugin-add $(yq ".[$i].name" $_file)
  $_asdf install $(yq ".[$i].name" $_file) $(yq ".[$i].version" $_file)
  $_asdf global $(yq ".[$i].name" $_file) $(yq ".[$i].version" $_file)
  if [ "$(yq ".[$i].packages" $_file)" == "null" ]; then continue; fi
  for j in $(seq 0 $(( $(yq ".[$i].packages | length" $_file) - 1 ))); do
    if [ "$(yq ".[$i].packages[$j].precommand" $_file)" != "null" ]; then eval $(yq ".[$i].packages[$j].precommand" $_file); fi
    for k in $(seq 0 $(( $(yq ".[$i].packages[$j].list" $_file | wc -l) - 1 ))); do
      _echo $_asdf_shims/$(yq ".[$i].packages[$j].command" $_file) $(yq ".[$i].packages[$j].list[$k]" $_file)
      $_asdf_shims/$(yq ".[$i].packages[$j].command" $_file) $(yq ".[$i].packages[$j].list[$k]" $_file)
    done
  done
done
$_asdf reshim

