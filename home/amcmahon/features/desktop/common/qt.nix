{ pkgs, ... }:
let
  theme = {
    qt = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };
in
{
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = {
      name = theme.qt.name;
      package = theme.qt.package;
    };
  };
}
