{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "ungoogled-chromium.desktop" ];
    "text/xml" = [ "ungoogled-chromium.desktop" ];
    "x-scheme-handler/http" = [ "ungoogled-chromium.desktop" ];
    "x-scheme-handler/https" = [ "ungoogled-chromium.desktop" ];
  };
}
