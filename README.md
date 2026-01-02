# dotfiles

* using [chezmoi](https://github.com/twpayne/chezmoi) to manage dotfiles
* using [mise](https://github.com/jdx/mise) to manage softwares for which multiple versions are desired (e.g. language-runtime)
* using [aqua](https://github.com/aquaproj/aqua) to manage some binaries

### pre-requirements

* `git` command
* `op` command
* 1Password account (required in executing `chezmoi apply` command)

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
bash $DOTFILES_DIR/.scripts/setup-mac.sh
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

