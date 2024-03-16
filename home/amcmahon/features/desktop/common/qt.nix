{ pkgs, ... }:
let
  theme = {
    qt = {
      name = "gtk2";
      package = pkgs.qt6Packages.qt6gtk2;
    };
  };
in
{
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = theme.qt.name;
      package = theme.qt.package;
    };
  };
}
