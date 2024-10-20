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
    platformTheme.name = "adwaita";
    style = {
      name = theme.qt.name;
      package = theme.qt.package;
    };
  };
}
