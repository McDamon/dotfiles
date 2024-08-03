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
    age
    alejandra
    ansible
    atop
    bc
    bind
    bottom
    calibre
    xreader
    fluxcd
    gh
    glances
    glxinfo
    gvfs
    htop
    iotop
    inetutils
    jq
    killall
    kodi-wayland
    kompose
    kubeconform
    kubectl
    kubernetes-helm
    kustomize
    minio-client
    neofetch
    networkmanager
    nil
    nixpkgs-fmt
    nvtopPackages.full
    onedrive
    p7zip
    pciutils
    picocom
    screen
    sops
    ssh-to-age
    terraform
    traceroute
    usbutils
    vim
    wireguard-tools
    xarchiver
    xclip
    xdg-utils
    xfce.thunar
    xfce.thunar-archive-plugin
    xorg.xauth
    xorg.xclock
    yq-go
  ];
}
