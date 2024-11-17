{ unstablePkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = unstablePkgs.vscode.fhs;
  };
}
