{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix
    ./direnv.nix
    ./keychain.nix
    ./screen.nix
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
