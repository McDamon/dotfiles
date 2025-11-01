{ pkgs, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        # Add your wallpaper paths here
        # Example: "~/Pictures/Wallpapers/wallpaper.png"
      ];

      wallpaper = [
        # Set wallpapers per monitor
        # Example: ",~/Pictures/Wallpapers/wallpaper.png"
        # Or per specific monitor: "DP-1,~/Pictures/Wallpapers/wallpaper.png"
      ];
    };
  };

  home.packages = with pkgs; [
    # Additional wallpaper tools
    hyprpaper
  ];
}
