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
    gnome = {
      gnome-keyring.enable = true;
      core-utilities.enable = false;
    };
  };
}
