{ inputs, pkgs, ... }: {
  imports = [
    ./global
    ./features/desktop/common
  ];
  
  colorscheme = inputs.nix-colors.colorschemes.tokyo-night-storm;
  wallpaper = pkgs.wallpapers.watercolor-beach;
  
  home.sessionVariables.EDITOR = "vim";
}
