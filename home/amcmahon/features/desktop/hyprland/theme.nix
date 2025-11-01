{ lib, config, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.theme = {
    colors = {
      background = mkOption {
        type = types.str;
        default = "#1e1e2e";
        description = "Background color";
      };
      foreground = mkOption {
        type = types.str;
        default = "#cdd6f4";
        description = "Foreground/text color";
      };
      primary = mkOption {
        type = types.str;
        default = "#89b4fa";
        description = "Primary accent color";
      };
      secondary = mkOption {
        type = types.str;
        default = "#f5c2e7";
        description = "Secondary accent color";
      };
      urgent = mkOption {
        type = types.str;
        default = "#f38ba8";
        description = "Urgent/error color";
      };
      warning = mkOption {
        type = types.str;
        default = "#fab387";
        description = "Warning color";
      };
      success = mkOption {
        type = types.str;
        default = "#a6e3a1";
        description = "Success color";
      };
      surface0 = mkOption {
        type = types.str;
        default = "#313244";
        description = "Surface color 0";
      };
      surface1 = mkOption {
        type = types.str;
        default = "#45475a";
        description = "Surface color 1";
      };
      surface2 = mkOption {
        type = types.str;
        default = "#585b70";
        description = "Surface color 2";
      };
      border = mkOption {
        type = types.str;
        default = "#89b4fa";
        description = "Border color";
      };
      borderInactive = mkOption {
        type = types.str;
        default = "#313244";
        description = "Inactive border color";
      };
    };
    font = {
      name = mkOption {
        type = types.str;
        default = config.fontProfiles.monospace.family or "monospace";
        description = "Font family name (uses fontProfiles.monospace if available)";
      };
      size = mkOption {
        type = types.int;
        default = 12;
        description = "Font size";
      };
    };
  };
}
