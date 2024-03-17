{ pkgs, ... }: {
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    MOZ_ENABLE_WAYLAND = 1;
  };
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
