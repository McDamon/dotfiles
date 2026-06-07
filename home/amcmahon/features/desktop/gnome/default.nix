{ ... }:
{
  imports = [
    ../common
    ../wayland
  ];

  dconf.settings = {
    "org/gnome/desktop/lockdown" = {
      "disable-log-out" = false;
      "disable-user-switching" = false;
    };
  };
}
