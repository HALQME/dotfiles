#!/bin/bash

brew --prefix

if [ $? = 0 ] ; then
	brew bundle --file Brewfile
fi

