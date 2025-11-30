{ lib, config, ... }:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.wallpaper;
in
{
  options.wallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable wallpaper management";
    };

    path = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/Pictures/Wallpapers/default.png";
      description = "Path to the wallpaper image";
      example = "${config.home.homeDirectory}/Pictures/Wallpapers/nature.jpg";
    };

    monitor = mkOption {
      type = types.str;
      default = "";
      description = "Monitor name (empty string means all monitors)";
      example = "DP-1";
    };
  };

  config = mkIf cfg.enable {
    # Ensure wallpaper directory exists
    home.file."Pictures/Wallpapers/.keep".text = "";

    assertions = [
      {
        assertion = cfg.path != "";
        message = "wallpaper.path must not be empty when wallpaper is enabled";
      }
      {
        assertion = lib.hasPrefix "/" cfg.path || lib.hasPrefix "~" cfg.path;
        message = "wallpaper.path must be an absolute path or start with ~";
      }
    ];
  };
}
