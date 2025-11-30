{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
