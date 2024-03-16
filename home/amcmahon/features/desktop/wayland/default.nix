{ pkgs, ... }: {
  imports = [
    ./kitty.nix
    ./mako.nix
    ./swaylock.nix
    ./waybar.nix
    ./wofi.nix
  ];
  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
    WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
    WLR_BACKEND = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  home.packages = with pkgs; [
    pulseaudio
  ];

  xdg.mimeApps.enable = true;
}
