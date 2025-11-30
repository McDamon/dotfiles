{ config, ... }:
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
      size = 12;
    };
    settings = {
      scrollback_lines = 10000;
      scrollback_pager_history_size = 2048;
      linux_display_server = "wayland";
      wayland_titlebar_color = "system";
    };
  };
}
