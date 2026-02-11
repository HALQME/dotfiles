.PHONY: switch build clean

switch:
	home-manager switch --flake .#hal

build:
	home-manager build --flake .#hal

clean:
	nix-collect-garbage -d
