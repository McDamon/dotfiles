{pkgs, ...}: {
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

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [gnomeExtensions.appindicator gnome.gnome-tweaks];
}
