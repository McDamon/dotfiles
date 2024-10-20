{ inputs, lib, pkgs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    ./common
    ./features/tools
    ./features/desktop/gnome
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  wallpaper = pkgs.wallpapers.aurora-borealis-water-mountain;
  colorscheme = lib.mkDefault colorSchemes.rose-pine-moon;
  specialisation = {
    light.configuration.colorscheme = colorSchemes.rose-pine-dawn;
  };

  monitors = [
    {
      name = "eDP-2";
      width = 1920;
      height = 1080;
      refreshRate = 144;
      workspace = "1";
      primary = true;
    }
  ];
}
