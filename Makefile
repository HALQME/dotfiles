# Do everything.
all: init brew link

# Set initial preference.
init:
	.bin/init.sh

# Install macOS applications.
brew:
	.bin/brew.sh

# Link dotfiles.
link:
	.bin/link.sh
