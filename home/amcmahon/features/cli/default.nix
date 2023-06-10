{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix
    ./gpg.nix
    ./direnv.nix
    ./screen.nix
    ./shellcolor.nix
    ./ssh.nix
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
    picocom
    screen
  ];
}
