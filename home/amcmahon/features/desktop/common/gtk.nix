{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
  };

  gtk = {
    enable = true;
    font = {
      name = config.fontProfiles.sansSerif.family;
      size = 12;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
