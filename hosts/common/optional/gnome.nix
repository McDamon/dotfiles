{
  services = {
    xserver = {
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
      };
    };
    geoclue2.enable = true;
    gnome.games.enable = true;
  };
}
