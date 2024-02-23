{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./git.nix
    ./gpg.nix
    ./direnv.nix
    ./screen.nix
    ./yubikey.nix
    ./zsh.nix
  ];
  home.packages = with pkgs; [
    ansible
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
    usbutils
  ];
}
