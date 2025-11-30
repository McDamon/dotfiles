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
      width = "25%";
      height = "60%";
      location = "top_left";
      x = 10;
      y = 10;

      # Appearance
      prompt = "";
      normal_window = false;
      layer = "overlay";
      term = "${lib.getExe config.programs.kitty.package}";
    };

    style = ''
      * {
        font-family: "${font.name}";
        font-size: ${toString font.size}pt;
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
    '';
  };
}
