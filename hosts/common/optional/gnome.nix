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
      layout = "gb";
      xkbVariant = "";
    };
    geoclue2.enable = true;
    gnome.games.enable = true;
  };
}
