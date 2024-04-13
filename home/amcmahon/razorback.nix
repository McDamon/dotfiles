{ inputs, lib, pkgs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    ./global
    ./features/cli/gpg-agent-gnome.nix
    ./features/desktop/gnome
    ./features/developer
    ./features/gaming
  ];

  home.sessionVariables = {
    EDITOR = "vim";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
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
