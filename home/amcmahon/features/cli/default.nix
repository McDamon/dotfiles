{ pkgs, ... }: {
  imports = [
    ./bash.nix
    ./cava.nix
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
    fluxcd
    glxinfo
    kubernetes-helm
    gh
    killall
    nil
    nixpkgs-fmt
    kubectl
    minio-client
    vim
    neofetch
    glances
    htop
    nvtopPackages.full
    onedrive
    iotop
    atop
    glances
    gvfs
    pciutils
    picocom
    p7zip
    screen
    terraform
    xfce.thunar
    xfce.thunar-archive-plugin
    usbutils
    xarchiver
    xorg.xauth
    xorg.xclock
    xclip
    xdg-utils
  ];
}
