# Usage

* download
```bash
git clone https://github.com/ShotaKitazawa/dotfiles $HOME/dotfiles
```

* deploy dotfiles
```bash
./dotfiles/put_profile
```

* source bashrc
```bash
. ~/.bashrc_self
```

* install applications
    * requirements: yq
```bash
./dotfiles/install_packages
```

# Memo

## Install packages for some environments

* Base package
    * mac: `xcode-select --install`
    * redhat: `yum install @base`
    * debian: `apt install build-essential software-properties-common`
* Repository
    * mac: install homebrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)`
    * redhat: `yum install epel-release`
    * debian: `add-apt-repository ppa:neovim-ppa/unstable`
* Xserver
    * mac/linux: default ok
    * wsl: download from https://sourceforge.net/projects/vcxsrv/ & install
* Python
    * install pyenv from https://github.com/pyenv/pyenv
* NeoVim
    * python3
        * `pip install neovim`
* Vim Plugin
    * python3
        * `pip install jedi flask autopep8`
    * golang
        * `go get -u github.com/nsf/gocode`
        * `go get -u github.com/golang/lint/golint`
    * C/C++
        * mac: `brew install clang-format`
        * redhat: TODO
        * debian: `apt install clang-format`
* mattn/memo
    * peco
        * install from https://github.com/peco/peco
    * GoogleDrive ($HOME/GoogleDrive)
        * for Linux: https://github.com/harababurel/gcsf
* tmux
    * shared clipboard
        * mac: nothing required (tmux2.6+)
        * wsl: download from https://github.com/equalsraf/win32yank/releases & deploy to $PATH
        * redhat: `yum install xsel`
        * debian: `apt install xsel`
* Other
    * mac
        * cask: `brew install cask`
        * macvim: `brew cask install macvim`
        * pdf viewer: `brew cask install Skim`
    * wsl
        * /bin/open: `cmd.exe /c start $@`
    * Windows (manually install)
        * pdf viewer: https://www.sumatrapdfreader.org/download-free-pdf-viewer.html
