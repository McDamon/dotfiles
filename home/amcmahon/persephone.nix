{ inputs, pkgs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/developer
    ./features/productivity
    ./features/games
    ./features/music
  ];

  home.sessionVariables.EDITOR = "vim";

  home.sessionVariables.XDG_DATA_HOME = "$HOME/.local/share";

  home.sessionVariables.WLR_NO_HARDWARE_CURSORS = 1;

  wallpaper = (import ./wallpapers).enami-beyond-hill-and-dale;
  colorscheme = inputs.nix-colors.colorschemes.atelier-forest;

  monitors = [
    {
      name = "HDMI-A-1";
      width = 3840;
      height = 2160;
      refreshRate = 60;
      workspace = "1";
    }
  ];
}
