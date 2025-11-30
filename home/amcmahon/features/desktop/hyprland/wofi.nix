{ config, lib, ... }:
let
  inherit (config.theme) colors font;
in
{
  programs.wofi = {
    enable = true;
    settings = {
      image_size = 48;
      columns = 3;
      allow_images = true;
      insensitive = true;
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
      matching = "multi-contains";

      # Window configuration
      width = "35%";
      height = "50%";
      location = "center";
      x = 0;
      y = 0;

      # Appearance
      prompt = "";
      normal_window = false;
      layer = "overlay";
      term = "${lib.getExe config.programs.kitty.package}";
    };

    style = ''
      * {
        font-family: "${config.fontProfiles.sansSerif.family}";
        font-size: ${toString (font.size + 2)}pt;
      }

      window {
        background-color: ${colors.background};
        border: 2px solid ${colors.primary};
        border-radius: 8px;
      }

      #input {
        background-color: ${colors.surface0};
        color: ${colors.foreground};
        border: 2px solid ${colors.primary};
        border-radius: 8px;
        padding: 8px 12px;
        margin: 10px;
      }

      #inner-box {
        background-color: ${colors.background};
        margin: 10px;
      }

      #outer-box {
        background-color: ${colors.background};
      }

      #scroll {
        margin: 0;
      }

      #text {
        color: ${colors.foreground};
        padding: 4px;
      }

      #entry {
        background-color: ${colors.background};
        padding: 8px;
        margin: 4px;
        border-radius: 8px;
      }

      #entry:selected {
        background-color: ${colors.primary};
        color: ${colors.background};
      }

      #entry:selected #text {
        color: ${colors.background};
      }

      #entry:hover {
        background-color: ${colors.surface1};
      }

      #entry:hover #text {
        color: ${colors.foreground};
      }
    '';
  };
}
