{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default.userSettings = {
      "editor.fontFamily" = config.fontProfiles.monospace.family;
      "terminal.integrated.fontFamily" = config.fontProfiles.monospace.family;
      "github.copilot.enable" = {
        "*" = false;
      };
      "github.copilot.inlineSuggest.enable" = false;
      "editor.inlineSuggest.enabled" = false;
    };
  };
}
