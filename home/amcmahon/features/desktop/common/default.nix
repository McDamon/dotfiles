{pkgs, ...}: {
  imports = [
    ./font.nix
    ./kitty.nix
    ./gtk.nix
    ./qt.nix
  ];

  home.packages = with pkgs; [
    google-chrome
  ];
}
