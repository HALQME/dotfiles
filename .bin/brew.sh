#!/bin/bash

brew --prefix

if [ $? = 0 ] ; then
	brew bundle --file "$(cd .. && pwd)/.dotfiles/.bin/Brewfile"
fi
