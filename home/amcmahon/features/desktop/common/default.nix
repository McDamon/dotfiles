{ ... }: {
  imports = [
    ./chromium.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./qt.nix
    #./obs-studio.nix
    ./pavucontrol.nix
    ./playerctl.nix
  ];
}
