{ config, lib, ... }:
let
  inherit (config.theme) colors font;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
        no_fade_out = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          size = "300, 50";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = colors.primary;
          inner_color = colors.surface0;
          font_color = colors.foreground;
          fade_on_empty = false;
          placeholder_text = "Enter Password...";
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Time
        {
          text = "cmd[update:1000] echo \"<span>$(date +'%H:%M')</span>\"";
          color = colors.foreground;
          font_size = 120;
          font_family = font.name;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # Date
        {
          text = "cmd[update:1000] echo \"<span>$(date +'%A, %B %d')</span>\"";
          color = colors.foreground;
          font_size = 24;
          font_family = font.name;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # User
        {
          text = "    $USER";
          color = colors.foreground;
          font_size = 18;
          font_family = font.name;
          position = "0, -60";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # Add lockscreen keybinding to Hyprland
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER,l,exec,${lib.getExe config.programs.hyprlock.package}"
  ];
}
