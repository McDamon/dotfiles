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
    bottom
    fluxcd
    gh
    glances
    glances
    glxinfo
    gvfs
    htop
    iotop
    jq
    killall
    kubeconform
    kubectl
    kubernetes-helm
    kustomize
    minio-client
    neofetch
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
    usbutils
    vim
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
