{ ... }: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "gb";
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
