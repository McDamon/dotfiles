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
      name = "DP-1";
      width = 3840;
      height = 2160;
      refreshRate = 120;
      workspace = "1";
    }
  ];
}
