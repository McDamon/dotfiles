{ pkgs, ... }:
{
  imports = [ ./kitty.nix ];
  home.packages = with pkgs; [
    grim
    gtk3 # For gtk-launch
    imv
    mimeo
    pulseaudio
    snapshot
    slurp
    spotify-player
    waypipe
    wf-recorder
    wl-clipboard
    wl-mirror
    ydotool
  ];

  xdg.mimeApps.enable = true;
}
