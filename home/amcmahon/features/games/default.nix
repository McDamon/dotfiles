{ pkgs, ... }: {
  imports = [
    ./protontricks.nix
  ];
  home.packages = with pkgs; [ gamescope ];
}
