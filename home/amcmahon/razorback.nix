{ inputs, pkgs, ... }: {
  imports = [
    ./global
    ./features/desktop/common
  ];
  
  colorscheme = inputs.nix-colors.colorschemes.tokyo-night-storm;

  home.sessionVariables.EDITOR = "vim";
}
