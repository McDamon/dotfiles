{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;
   
    enableExtensionUpdateCheck = false;
  
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [
      llvm-vs-code-extensions.vscode-clangd
      ms-vscode.cpptools
      vadimcn.vscode-lldb
      twxs.cmake
      ms-vscode.cmake-tools
      donjayamanne.githistory
      jnoortheen.nix-ide
      mkhl.direnv
      rust-lang.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
      ms-python.python
      zxh404.vscode-proto3
    ];

    userSettings = {
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Default Dark Modern";
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font";
      "terminal.integrated.fontLigatures" = true;
      "terminal.integrated.fontSize" = 12;
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "editor.fontLigatures" = 12;
    };
  };
}
