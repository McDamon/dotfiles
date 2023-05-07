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

  wallpaper = (import ./wallpapers).enami-beyond-hill-and-dale;
  colorscheme = inputs.nix-colors.colorschemes.atelier-forest;

  monitors = [
  {
    name = "eDP-1";
    width = 1920;
    height = 1200;
    refreshRate = 60;
    x = 3440;
    workspace = "1";
  }
  {
    name = "DP-2";
    width = 2560;
    height = 1440;
    refreshRate = 144;
    x = 100;
    y = 1440;
    workspace = "3";
  }
  {
    name = "DP-1";
    width = 3440;
    height = 1440;
    refreshRate = 144;
    x = 0;
    workspace = "2";
  }];
}
