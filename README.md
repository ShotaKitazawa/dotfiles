# Usage

* download
```bash
git clone https://github.com/ShotaKitazawa/dotfiles $HOME/dotfiles
```

* check tmux version & link to .tmux.conf
```bash
cd $HOME/dotfiles
ln -s tmux-before2.4/.tmux.conf .
```

* deploy
```bash
./dotfiles/putprofile
```

# Requirement

* https://github.com/ShotaKitazawa/playbook-devenv

* NeoVim
    * python3
        * `pip install neovim`
* Vim Plugin
    * python3
        * `pip install
* mattn/memo
    * peco
    * GoogleDrive ($HOME/GoogleDrive)
        * for Linux: https://github.com/harababurel/gcsf
* tmux
    * shared clipboard
        * mac: `brew install reattach-to-user-namespace`
        * wsl: download from https://github.com/equalsraf/win32yank/releases & deploy to $PATh
        * redhat: `yum install xsel`
        * debian: `apt install xsel`

# Memo

```
brew update
brew install python3
brew install neovim/neovim/neovim
pip3 install neovim
# MacVim
brew install cask
brew cask install macvim
# Go
brew install golang
go get -u github.com/nsf/gocode
go get -u github.com/golang/lint/golint
# C/C++
brew install clang-format
# Python
pip3 install jedi flask autopep8
# LaTeX
brew cask install mactex
brew install ghostscript
brew install imagemagick
```

