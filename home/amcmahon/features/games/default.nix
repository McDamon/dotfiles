{ pkgs, ... }: {
  imports = [
    ./protontricks.nix
    ./faf-client.nix
  ];
  home.packages = with pkgs; [ gamescope ];
}
