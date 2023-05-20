{ pkgs, ... }: {
  imports = [
    ./faf-client.nix
    ./protontricks.nix
  ];
  home.packages = with pkgs; [ gamescope ];
}
