#/bin/sh
echo "if [ -f ~/.bashrc_self ]; then source ~/.bashrc_self; fi" >> ~/.bashrc
if [ ! -f ~/dotfiles/.bashrc_self ]; then ln -s ~/dotfiles/.bashrc_self ~/; fi
if [ ! -d ~/vimundo ]; then mkdir ~/vimundo; fi
