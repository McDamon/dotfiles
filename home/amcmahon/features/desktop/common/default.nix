{ ... }: {
  imports = [
    ./chromium.nix
    ./font.nix
    ./gtk.nix
    ./qt.nix
    #./obs-studio.nix
    ./pavucontrol.nix
    ./playerctl.nix
  ];
}
