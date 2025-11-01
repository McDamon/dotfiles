{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles.default.userSettings = {
      # Prevent opening in new workspace
      "window.openFoldersInNewWindow" = "off";
      "window.openFilesInNewWindow" = "off";
      # Don't restore previous windows/workspaces
      "window.restoreWindows" = "none";
    };
  };
}
