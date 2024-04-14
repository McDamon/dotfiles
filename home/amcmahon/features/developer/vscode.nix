{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

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
      hashicorp.hcl
      hashicorp.terraform
    ];

    userSettings = {
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Default Dark Modern";
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font";
      "terminal.integrated.fontSize" = 12;
      "editor.fontFamily" = "FiraCode Nerd Font";
      "cmake.showOptionsMovedNotification" = false;
      "C_Cpp.intelliSenseEngine" = "disabled";
      "cmake.showConfigureWithDebuggerNotification" = false;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
          "flake" = {
            "autoArchive" = false;
          };
        };
      };
    };
  };
}
