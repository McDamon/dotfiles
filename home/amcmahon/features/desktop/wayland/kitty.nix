{ config, ... }:
let
  inherit (config.theme) colors;
in
{
  # Set as default terminal
  xdg.mimeApps = {
    associations.added = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
    defaultApplications = {
      "x-scheme-handler/terminal" = "kitty.desktop";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = config.fontProfiles.monospace.family;
      size = 11;
    };
    settings = {
      # Scrollback
      scrollback_lines = 10000;
      scrollback_pager_history_size = 10;

      # Window
      window_padding_width = 8;
      hide_window_decorations = "yes";
      confirm_os_window_close = 0;

      # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = "1.5";
      cursor_blink_interval = 0;

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";

      # Wayland
      linux_display_server = "wayland";
      wayland_titlebar_color = "system";

      # Appearance
      background_opacity = "0.95";
      background_blur = 1;

      # Theme colors
      foreground = colors.foreground;
      background = colors.background;
      selection_foreground = colors.background;
      selection_background = colors.primary;

      # Cursor colors
      cursor = colors.foreground;
      cursor_text_color = colors.background;

      # URL color
      url_color = colors.primary;

      # Tab bar
      active_tab_foreground = colors.background;
      active_tab_background = colors.primary;
      inactive_tab_foreground = colors.foreground;
      inactive_tab_background = colors.surface0;
      tab_bar_background = colors.background;

      # Normal colors
      color0 = colors.surface0;
      color1 = colors.urgent;
      color2 = colors.success;
      color3 = colors.warning;
      color4 = colors.primary;
      color5 = colors.secondary;
      color6 = colors.primary;
      color7 = colors.foreground;

      # Bright colors
      color8 = colors.surface1;
      color9 = colors.urgent;
      color10 = colors.success;
      color11 = colors.warning;
      color12 = colors.primary;
      color13 = colors.secondary;
      color14 = colors.primary;
      color15 = colors.foreground;
    };
  };
}
