{ pkgs, ... }:
let
  theme = with pkgs; {
    qt = {
      name = "kvantum";
      package = qt6Packages.qtstyleplugin-kvantum;
    };
  };
in
{
  qt = {
    enable = true;
    platformTheme = "lxqt";
    style = {
      name = theme.qt.name;
      package = theme.qt.package;
    };
  };
}