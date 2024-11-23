{ ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "intl";
      };
    };
    displayManager.defaultSession = "plasma";
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;
  };
}
