set shell := ["bash", "-euo", "pipefail", "-c"]

fmt:
  treefmt

check:
  nix flake check

switch-home:
  home-manager switch --flake .#amcmahon@rocinante

rebuild-host:
  sudo nixos-rebuild switch --flake .#rocinante

update:
  nix flake update
  just fmt
  just check

clean:
  nix-collect-garbage -d
  nix store gc
