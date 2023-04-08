{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    protontricks
  ];
}
