{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./shellcolor.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    nil
    nixfmt
    nixpkgs-fmt
    vim
    neofetch
    glances
    htop
  ];
}
