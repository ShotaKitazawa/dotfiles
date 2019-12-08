#!/bin/bash

set -u

cd $(cd $(dirname $0) && pwd)

LOGGER_STDOUT=${LOGGER_STDOUT:-'/dev/null'}
LOGGER_STDERR=${LOGGER_STDERR:-'/dev/null'}

switch_env () {
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

_echo () {
  echo $@ | tee -a $LOGGER_STDOUT | tee -a $LOGGER_STDERR
}

# create $HOME/bin
if [ ! -e $HOME/bin ]; then mkdir $HOME/bin; fi

# install required application: yq
YQ_VERSION=2.3.0
_echo "### install yq ###"
curl -s0L https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_$(switch_env linux darwin linux)_amd64 -o $HOME/bin/yq > $LOGGER_STDOUT 2> $LOGGER_STDERR
chmod 0755 $HOME/bin/yq
_echo "-> installed"

_echo '### download.yml ###'
_file="./requirements/download.yml"
for i in $(seq 0 $(( $(yq r $_file "[*].name" | wc -l) - 1 ))); do
  _echo "-> install $(yq r $_file "[$i].name")"
  case $(yq r $_file [$i].type) in
    "text")
      yq r $_file "[$i].contents" > $(eval echo $(yq r $_file [$i].path))
      chmod $(yq r $_file "[$i].mode") $(eval echo $(yq r $_file [$i].path))
      ;;
    "clone")
      git clone $(yq r $_file "[$i].url") -b $(yq r $_file "[$i].version") $(eval echo $(yq r $_file "[$i].path")) > $LOGGER_STDOUT 2> $LOGGER_STDERR
      if [ "$(yq r $_file "[$i].option")" != "null" ]; then
        eval $(yq r $_file "[$i].option") > $LOGGER_STDOUT 2> $LOGGER_STDERR
      fi
      ;;
  esac
done

_echo '### asdf.yml ###'
_file="./requirements/asdf.yml"
# TODO

_echo '### package.yml ###'
_file="./requirements/package.yml"
if [[ "$(switch_env linux mac wsl)" = 'mac' ]]; then
  # for macOS
  if brew -v > $LOGGER_STDOUT 2> $LOGGER_STDERR; then
    for i in $(seq 0 $(( $(yq r $_file "mac.brew" | wc -l) - 1 ))); do
      _echo "-> brew install $(yq r $_file "mac.brew[$i]")"
      brew install $(yq r $_file "mac.brew[$i]") > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
    for i in $(seq 0 $(( $(yq r $_file "mac.cask" | wc -l) - 1 ))); do
      _echo "-> brew cask install $(yq r $_file "mac.cask[$i]")"
      brew cask install $(yq r $_file "mac.cask[$i]") > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
  fi
elif [[ "$(switch_env linux mac wsl)" = 'linux' ]]; then
  if [ -e /etc/redhat-release ]; then
    # for CentOS & RHEL
    for i in $(seq 0 $(( $(yq r $_file "redhat.yum" | wc -l) - 1 ))); do
      _echo "-> yum install -y $(yq r $_file "redhat.yum[$i]")"
      yum install -y $(yq r $_file "redhat.yum[$i]") > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
    yum update > /dev/null 2>&1
    for i in $(seq 0 $(( $(yq r $_file "redhat.yum-epel" | wc -l) - 1 ))); do
      _echo "-> yum --enablerepo=epel install -y $(yq r $_file "redhat.yum-epel[$i]")"
      yum --enablerepo=epel install -y $(yq r $_file "redhat.yum-epel[$i]") > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
  elif [ -e /etc/lsb-release ]; then
    # for Ubuntu
    for i in $(seq 0 $(( $(yq r $_file "ubuntu.apt" | wc -l) - 1 ))); do
      _echo "-> apt install -y $(yq r $_file "ubuntu.apt[$i]")"
      apt install -y $(yq r $_file "ubuntu.apt[$i]") > $LOGGER_STDOUT 2> $LOGGER_STDERR
    done
  fi
fi
