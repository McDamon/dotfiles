{ pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  # Override VSCode desktop entry to ensure proper Wayland rendering
  xdg.desktopEntries.code = {
    name = "Visual Studio Code";
    genericName = "Text Editor";
    exec = "${lib.getExe pkgs.vscode.fhs} --enable-features=UseOzonePlatform --ozone-platform=wayland %F";
    icon = "vscode";
    comment = "Code Editing. Redefined.";
    categories = [ "Utility" "TextEditor" "Development" "IDE" ];
    mimeType = [ "text/plain" "inode/directory" ];
    startupNotify = true;
    actions = {
      new-empty-window = {
        name = "New Empty Window";
        exec = "${lib.getExe pkgs.vscode.fhs} --enable-features=UseOzonePlatform --ozone-platform=wayland --new-window %F";
        icon = "vscode";
      };
    };
  };
}
