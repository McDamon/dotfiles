{ ... }: {
  imports = [
    ../common
    ../wayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
    };

    settings = {
    };
  };
}
