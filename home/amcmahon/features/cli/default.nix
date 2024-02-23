{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix
    ./direnv.nix
    ./screen.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    bc
    bottom
    jq
    nil
    nixfmt
    nixpkgs-fmt
    vim
    neofetch
    glances
    htop
    pciutils
    picocom
    screen
  ];
}
