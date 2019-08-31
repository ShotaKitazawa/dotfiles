#!/bin/bash

cd $(dirname $0) && pwd

LOGGER_STDOUT='/dev/null'
LOGGER_STDERR='/dev/null'

switch_env(){
  if [[ "$(uname)" = 'Darwin' ]]; then
    echo $2
  elif [[ "$(uname -r)" =~ ^.*-Microsoft$ ]]; then
    echo $3
  elif [[ "$(uname)" = 'Linux' ]]; then
    echo $1
  elif [[ "$(uname)" = 'FreeBSD' ]]; then
    echo $4
  fi
}

source ./requirements/git.sh

# create $HOME/bin
if [ ! -e $HOME/bin ]; then mkdir $HOME/bin; fi

# install required application: yq
YQ_VERSION=2.3.0
echo "> install yq" | tee $LOGGER_STDOUT
curl -0L https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_$(switch_env linux darwin linux)_amd64 > $HOME/bin/yq 2> $LOGGER_STDERR
chmod 0755 $HOME/bin/yq
echo "-> installed" | tee $LOGGER_STDOUT


echo "> install kubectl-get_all" | tee $LOGGER_STDOUT
cat <<'_EOF_' > $HOME/bin/kubectl-get_all
#!/usr/bin/env bash
set -e -o pipefail; [[ -n "$DEBUG" ]] && set -x
exec kubectl get "$(kubectl api-resources --namespaced=true --verbs=list --output=name | tr "\n" "," | sed -e 's/,$//')" "$@"
_EOF_
chmod 0755 $HOME/bin/kubectl-get_all
echo "-> installed" | tee $LOGGER_STDOUT


echo "> install peco" | tee $LOGGER_STDOUT
curl -0L https://github.com/peco/peco/releases/download/${PECO_VERSION}/peco_$(switch_env linux darwin linux)_amd64.zip > /tmp/peco.zip 2> $LOGGER_STDERR
cd /tmp
  unzip /tmp/peco.zip
  mv /tmp/peco_$(switch_env linux darwin linux)_amd64/peco $HOME/bin/peco
  chmod 0755 $HOME/bin/peco
cd -
echo "-> installed" | tee $LOGGER_STDOUT

echo "> install fzf" | tee $LOGGER_STDOUT
if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 2> $LOGGER_STDERR
  git checkout $FZF_VERSINO
  if ~/.fzf/install --all 2> $LOGGER_STDERR; then
    echo "-> installed" | tee $LOGGER_STDOUT
  else
    echo "-> error: failed to download fzf" | tee $LOGGER_STDOUT
  fi
fi


echo "> install pyenv" | tee $LOGGER_STDOUT
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv ~/.pyenv 2> $LOGGER_STDERR
  git checkout $PYENV_VERSION
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
  echo "-> installed" | tee $LOGGER_STDOUT
else
  echo "-> pass" | tee $LOGGER_STDOUT
fi


# TODO: pyenv install -s が動かない > 手動インストールで対応
echo "> install python packages" | tee $LOGGER_STDOUT
if pyenv install -s $(cat ./requirements/language.yml | yq r - python.version) > $LOGGER_STDOUT 2> $LOGGER_STDERR; then
  pyenv global $(cat ./requirements/language.yml | yq r - python.version)
  for i in $(seq 0 $(( $(cat ./requirements/language.yml | yq r - python.packages | wc -l | awk '{print $1}') - 1 ))); do
    echo "-> pip install -U $(cat ./requirements/language.yml | yq r - python.packages[$i])" | tee $LOGGER_STDOUT
    pip install -U $(cat ./requirements/language.yml | yq r - python.packages[$i]) > $LOGGER_STDOUT 2> $LOGGER_STDERR
  done
fi


echo "> install goenv" | tee $LOGGER_STDOUT
if [ ! -d ~/.goenv ]; then
  git clone https://github.com/syndbg/goenv ~/.goenv 2> $LOGGER_STDERR
  git checkout $GOENV_VERSION
  echo "-> installed" | tee $LOGGER_STDOUT
else
  echo "-> pass" | tee $LOGGER_STDOUT
fi


# TODO: goenv install -s が動かない > 手動インストールで対応
echo "> install golang packages" | tee $LOGGER_STDOUT
if goenv install -s $(cat ./requirements/language.yml | yq r - go.version) > $LOGGER_STDOUT 2> $LOGGER_STDERR; then
  goenv global $(cat ./requirements/language.yml | yq r - go.version)
  for i in $(seq 0 $(( $(cat ./requirements/language.yml | yq r - go.packages | wc -l | awk '{print $1}') - 1 ))); do
    echo "-> go get -u $(cat ./requirements/language.yml | yq r - go.packages[$i])" | tee $LOGGER_STDOUT
    go get -u $(cat ./requirements/language.yml | yq r - go.packages[$i]) > $LOGGER_STDOUT 2> $LOGGER_STDERR
  done

fi

echo "> install peda (gdb extension)" | tee $LOGGER_STDOUT
if [ ! -d ~/.peda ]; then
  git clone https://github.com/longld/peda ~/.peda 2> $LOGGER_STDERR
  git checkout $PEDA_VERSION
  echo "-> installed" | tee $LOGGER_STDOUT
else
  echo "-> pass" | tee $LOGGER_STDOUT
fi

echo "> install Powerline fonts" | tee $LOGGER_STDOUT
if [ ! -d ~/.fonts ]; then
  git clone https://github.com/powerline/fonts.git ~/.fonts 2> $LOGGER_STDERR
  git checkout $POWERLINE_FONT_VERSION
  if ~/.fonts/install.sh > /dev/null; then
    echo "-> installed" | tee $LOGGER_STDOUT
  else
    echo "-> error: failed to download Powerline fonts" | tee $LOGGER_STDOUT
  fi
else
  echo "-> pass" | tee $LOGGER_STDOUT
fi

echo "> install Monaco Powerline fonts" | tee $LOGGER_STDOUT
wget https://gist.github.com/baopham/1838072/raw/2c0e00770826e651d1e355962e751325edb0f1ee/Monaco%20for%20Powerline.otf -O $(switch_env $HOME/.local/share/fonts $HOME/Library/Fonts $HOME/.local/share/fonts)
echo "-> installed" | tee $LOGGER_STDOUT

echo "> for each OS"
if [[ "$(uname)" = 'Darwin' ]]; then
  # for macOS
  if brew -v > $LOGGER_STDOUT 2> $LOGGER_STDERR; then
    for i in $(seq 0 $(( $(cat ./requirements/os.yml | yq r - mac.brew | wc -l | awk '{print $1}') - 1 ))); do
      echo "-> brew install $(cat ./requirements/os.yml | yq r - mac.brew[$i])" | tee $LOGGER_STDOUT
      brew install $(cat ./requirements/os.yml | yq r - mac.brew[$i]) > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
    for i in $(seq 0 $(( $(cat ./requirements/os.yml | yq r - mac.cask | wc -l | awk '{print $1}') - 1 ))); do
      echo "-> brew cask install $(cat ./requirements/os.yml | yq r - mac.cask[$i])" | tee $LOGGER_STDOUT
      brew cask install $(cat ./requirements/os.yml | yq r - mac.cask[$i]) > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
  fi
elif [[ "$(uname)" = 'Linux' ]]; then
  if [ -e /etc/redhat-release ]; then
    # for CentOS & RHEL
    for i in $(seq 0 $(( $(cat ./requirements/os.yml | yq r - redhat.yum | wc -l | awk '{print $1}') - 1 ))); do
      echo "-> yum install -y $(cat ./requirements/os.yml | yq r - redhat.yum[$i])" | tee $LOGGER_STDOUT
      yum install -y $(cat ./requirements/os.yml | yq r - redhat.yum[$i]) > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
    yum update > /dev/null 2>&1
    for i in $(seq 0 $(( $(cat ./requirements/os.yml | yq r - redhat.yum-epel | wc -l | awk '{print $1}') - 1 ))); do
      echo "-> yum --enablerepo=epel install -y $(cat ./requirements/os.yml | yq r - redhat.yum-epel[$i])" | tee $LOGGER_STDOUT
      yum --enablerepo=epel install -y $(cat ./requirements/os.yml | yq r - redhat.yum-epel[$i]) > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
  elif [ -e /etc/lsb-release ]; then
    # for Ubuntu
    for i in $(seq 0 $(( $(cat ./requirements/os.yml | yq r - redhat.yum | wc -l | awk '{print $1}') - 1 ))); do
      echo "-> apt install -y $(cat ./requirements/os.yml | yq r - ubuntu.apt[$i])" | tee $LOGGER_STDOUT
      apt install -y $(cat ./requirements/os.yml | yq r - ubuntu.apt[$i]) > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
  fi
fi
