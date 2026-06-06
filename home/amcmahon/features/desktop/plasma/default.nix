{ pkgs, ... }:
{
  imports = [
    ../common
    ../wayland
  ];

  home.packages = with pkgs; [
    kdePackages.plasma-browser-integration
  ];
}
