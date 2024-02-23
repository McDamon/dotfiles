{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator gnome3.gnome-tweaks ];
}
