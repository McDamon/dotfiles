{ pkgs, ... }: {
  imports = [
    ./lutris.nix
    ./protontricks.nix
    ./faf-client.nix
  ];
  home.packages = with pkgs; [ gamescope ];
}
