{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./shellcolor.nix
  ];
  home.packages = with pkgs; [
    nil
    nixfmt
    vim
  ];
}
