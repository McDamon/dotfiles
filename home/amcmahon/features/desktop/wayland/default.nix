{ pkgs, ... }: {
  imports = [
    ./kitty.nix
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
  home.packages = with pkgs; [
    pulseaudio
  ];

  xdg.mimeApps.enable = true;
}
