# Check Operating System
if [ "$(uname)" = "Darwin" ] ; then
	echo "install on Darwin."
	# Install xcode
	xcode-select --install > /dev/null

	# Install brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null

elif [ "$(uname -s)" = "Linux" ] ; then
	echo "install on Linux."
else
	exit 1
fi

# Set bash
chsh -s /bin/zsh
if [ $? != 0 ] ; then
	echo "Cannot set Zsh as default shell"
fi


# Install VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "After you set ~/.vimrc and write your plugins, execute :PlugInstall on Vim"

