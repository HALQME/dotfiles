.PHONY: sync sync-gui build clean

sync:
	home-manager switch --flake .#hal -b backup

sync-gui:
	home-manager switch --flake .#hal-full -b backup

build:
	home-manager build --flake .#hal

clean:
	nix-collect-garbage -d