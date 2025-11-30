{ ... }:
{
  imports = [
    ./common
    ./features/tools
    ./features/desktop/hyprland
  ];

  home.sessionVariables = {
    EDITOR = "code";
    DEFAULT_BROWSER = "google-chrome";
    BROWSER = "google-chrome";
  };

  monitors = [
    {
      name = "HDMI-A-2";
      width = 3840;
      height = 2160;
      refreshRate = 120;
      scale = "1.25";
      workspace = "1";
      primary = true;
      hdr = true;
    }
  ];
}
