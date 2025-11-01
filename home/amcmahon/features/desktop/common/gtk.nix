{
  config,
  pkgs,
  ...
}:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.sansSerif.family;
      size = 12;
    };
    theme = {
      name = "adwaita";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}
