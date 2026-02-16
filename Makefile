.PHONY: switch build clean

switch:
	home-manager switch --flake .#hal -b backup

build:
	home-manager build --flake .#hal

clean:
	nix-collect-garbage -d
