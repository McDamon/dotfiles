{ inputs, pkgs, ... }: {
  imports = [
    ./global
    ./features/desktop/common
  ];

  home.sessionVariables.EDITOR = "vim";
}
