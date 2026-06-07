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
    "org/gnome/desktop/session" = {
      "idle-delay" = 0;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      "ambient-enabled" = false;
      "idle-dim" = false;
      "sleep-inactive-ac-timeout" = 0;
      "sleep-inactive-ac-type" = "nothing";
      "sleep-inactive-battery-timeout" = 0;
      "sleep-inactive-battery-type" = "nothing";
    };
  };
}
