awesome:
	ln -s . ~/.config

conky: 
	ln -s $FILENAME ~/.conkyrc

fonts:
	ln -s $FILENAME /etc/fonts/local.conf

slim:
	ln -s $FILENAME /usr/share/slim/themes/

terminator:
	ln -s $FILENAME ~/.config/terminator

vim:
	ln -s $FILENAME ~/.vim
	ln -s $FILENAME ~/.vimrc

xinit:
	ln -s $FILENAME ~/.xinitrc

zsh:
	ln -s $FILENAME ~/.zshrc

