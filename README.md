# dotfiles

* using [chezmoi](https://github.com/twpayne/chezmoi) for managing dotfiles
    * using [aqua](https://github.com/aquaproj/aqua) for managing tools
    * using [asdf](https://github.com/asdf-vm/asdf) for managing language-runtimes

### requirements

* git
* 1password Account (required in `deploy dotfiles by chezmoi`)

### setup

* setup envvars

```bash
export DOTFILES_DIR="$HOME/.ghq/github.com/ShotaKitazawa/dotfiles"
```

* clone dotfiles

```bash
git clone git@github.com:ShotaKitazawa/dotfiles $DOTFILES_DIR
```

* install initial softwares

```bash
# for macOS (install only Homebrew & chezmoi)
bash $DOTFILES_DIR/setup-mac.sh
```

* setup chezmoi

```bash
cat << _EOF_ >> ~/.zshrc

# chezmoi
alias chezmoi="chezmoi -S ${DOTFILES_DIR}"
_EOF_
```

### apply

* deploy dotfiles by [chezmoi](https://github.com/twpayne/chezmoi)

```bash
chezmoi apply
```

### change login shell

* `sudo vim /etc/shells`

```diff
  ...
+ /usr/local/bin/zsh
```

* reboot

* change login shell

```bash
chsh -s /opt/homebrew/bin/zsh
```

