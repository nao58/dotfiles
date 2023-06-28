all:
	$(MAKE) essential zsh vim

brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

essential:
	brew upgrade
	brew install git
	brew install wget

zsh:
	ln -fs ~/dotfiles/zshrc ~/.zshrc

vim:
	sh -c "$$(wget -O- https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
	ln -fs ~/dotfiles/vimrc ~/.vimrc
