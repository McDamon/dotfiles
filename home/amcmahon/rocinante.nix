{ inputs, lib, pkgs, ... }:
let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  imports = [
    ./global
    ./features/cli/gpg-agent-gtk.nix
    ./features/desktop/hyprland
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
      name = "HDMI-A-1";
      width = 3840;
      height = 2160;
      refreshRate = 120;
      workspace = "1";
      primary = true;
    }
  ];
}
