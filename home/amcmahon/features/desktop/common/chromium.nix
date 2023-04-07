{ pkgs, lib, inputs, ... }:
{
  programs.browserpass.enable = true;
  programs.google-chrome = {
    enable = true;
  };

  home = {
    sessionVariables.BROWSER = "google-chrome";
    sessionVariables.NIXOS_OZONE_WL  = "1";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "google-chrome.desktop" ];
    "text/xml" = [ "google-chrome.desktop" ];
    "x-scheme-handler/http" = [ "google-chrome.desktop" ];
    "x-scheme-handler/https" = [ "google-chrome.desktop" ];
  };
}
