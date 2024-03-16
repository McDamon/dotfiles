{ pkgs, ... }: {
  imports = [
    ./font.nix
    ./kitty.nix
    ./gtk.nix
    ./qt.nix
  ];
}
