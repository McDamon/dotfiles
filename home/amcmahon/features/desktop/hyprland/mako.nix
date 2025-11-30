{ config, ... }:
let
  inherit (config.theme) colors font;
in
{
  services.mako = {
    enable = true;

    settings = {
      font = "${font.name} ${toString font.size}";

      # Appearance
      background-color = colors.surface0;
      text-color = colors.foreground;
      border-color = colors.primary;
      border-size = 2;
      border-radius = 8;

      # Layout
      width = 400;
      height = 150;
      margin = "10";
      padding = "15";

      # Position
      anchor = "top-right";

      # Behavior
      default-timeout = 5000;
      ignore-timeout = false;

      # Grouping
      max-visible = 5;
      sort = "-time";

      # Icons
      icon-path = "";
      max-icon-size = 48;

      # Progress bar
      progress-color = "over ${colors.primary}";
    };

    extraConfig = ''
      [urgency=low]
      border-color=${colors.success}
      default-timeout=3000

      [urgency=normal]
      border-color=${colors.primary}
      default-timeout=5000

      [urgency=high]
      border-color=${colors.urgent}
      default-timeout=0

      [category=mpd]
      default-timeout=2000
      group-by=category
    '';
  };
}
