{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Enable wallpaper management
  wallpaper.enable = lib.mkDefault true;

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = lib.mkIf config.wallpaper.enable [ config.wallpaper.path ];

      wallpaper = lib.mkIf config.wallpaper.enable [
        "${config.wallpaper.monitor},${config.wallpaper.path}"
      ];
    };
  };

  home.packages = with pkgs; [ hyprpaper ];
}
