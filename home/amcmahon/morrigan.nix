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
    EDITOR = "code";
    DEFAULT_BROWSER = "google-chrome";
    BROWSER = "google-chrome";
  };

  wallpaper = pkgs.wallpapers.aurora-borealis-water-mountain;
  colorscheme = lib.mkDefault colorSchemes.paraiso;
  specialisation = {
    light.configuration.colorscheme = colorSchemes.paraiso;
  };

  monitors = [
    {
      name = "eDP-2";
      width = 1920;
      height = 1200;
      refreshRate = 60;
      workspace = "1";
      primary = true;
    }
  ];
}
