{
  config,
  pkgs,
  ...
}: let
  kitty-xterm = pkgs.writeShellScriptBin "xterm" ''
    ${config.programs.kitty.package}/bin/kitty -1 "$@"
  '';
in {
  home = {
    packages = [kitty-xterm];
    sessionVariables = {
      TERMINAL = "kitty -1";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = config.fontProfiles.monospace.family;
      size = 12;
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Desert";
    settings = {
      remember_window_size = "no";
      initial_window_width = 1080;
      initial_window_height = 760;
      linux_display_server = "x11";
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 15;
    };
  };
}
