{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System Monitoring
    atop
    bottom
    glances
    htop
    iotop
    nvtopPackages.full

    # System Information
    lshw
    neofetch
    pciutils
    usbutils
    mesa-demos

    # Network Tools
    bind
    networkmanager
    traceroute
    wireguard-tools

    # File Management
    gvfs
    p7zip
    tree
    xarchiver
    xfce.thunar
    xfce.thunar-archive-plugin

    # Terminal & Shell
    bc
    jq
    killall
    screen
    tmux
    wget
    yq-go

    # X11 Tools
    xclip
    xdg-utils
    xorg.xauth
    xorg.xclock
    xorg.xkill

    # Hardware & Firmware
    picocom
    sbctl

    # Misc
    appimage-run
    onedrive
  ];
}
