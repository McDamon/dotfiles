set shell := ["bash", "-euo", "pipefail", "-c"]

fmt:
  treefmt

check:
  nix flake check

home-switch:
  home-manager switch --flake .#amcmahon@rocinante

rebuild-switch:
  sudo nixos-rebuild switch --flake .#rocinante

update:
  nix flake update
  just fmt
  just check

clean:
  nix-collect-garbage -d
  nix store gc

clean-all:
  just clean
  sudo nix-collect-garbage -d
  sudo nix store gc
