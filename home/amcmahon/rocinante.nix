{ inputs, lib, pkgs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    ./global
    ./features/desktop/common
    ./features/desktop/wayland
    ./features/developer
  ];

  home.sessionVariables.EDITOR = "vim";

  wallpaper = pkgs.wallpapers.aurora-borealis-water-mountain;
  colorscheme = lib.mkDefault colorSchemes.rose-pine-moon;
  specialisation = {
    light.configuration.colorscheme = colorSchemes.rose-pine-dawn;
  };
}
