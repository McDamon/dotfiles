{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./blueman.nix
    ./chromium.nix
    ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./dragon.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./qt.nix
  ];

  xdg.mimeApps.enable = true;
}
