{ pkgs, ... }: {
  imports = [
    ./lutris.nix
    ./lutris.nix
    ./protontricks.nix
    ./faf-client.nix
  ];
  home.packages = with pkgs; [ gamescope ];
}
