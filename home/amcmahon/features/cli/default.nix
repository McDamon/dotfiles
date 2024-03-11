{pkgs, ...}: {
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
    alejandra
    ansible
    bc
    bottom
    jq
    glxinfo
    killall
    nil
    nixfmt
    nixpkgs-fmt
    minio-client
    vim
    neofetch
    glances
    htop
    pciutils
    picocom
    screen
    usbutils
    xorg.xauth
    xorg.xclock
    xclip
  ];
}
