{ pkgs, ... }: {
  imports = [
    ./lutris.nix
    ./lutris.nix
    ./steam.nix
    ./faf-client.nix
  ];
  home.packages = with pkgs; [ gamescope ];
}
