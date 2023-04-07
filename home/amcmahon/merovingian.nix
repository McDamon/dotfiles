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

  wallpaper = (import ./wallpapers).enami-beyond-hill-and-dale;
  colorscheme = inputs.nix-colors.colorschemes.embers;

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
    name = "DP-3";
    width = 3440;
    height = 1440;
    refreshRate = 144;
    x = 0;
    workspace = "2";
  }];
}
