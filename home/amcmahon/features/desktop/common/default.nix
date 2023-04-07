{ pkgs, lib, outputs, ... }:
{
  imports = [
    ./chromium.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
  ];

  xdg.mimeApps.enable = true;
}
