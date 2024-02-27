{ inputs, pkgs, ... }: {
  imports = [
    ./global
  ];
  
  home.sessionVariables.EDITOR = "vim";
}