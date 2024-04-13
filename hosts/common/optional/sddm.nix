{ ... }: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "intl";
      };
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
