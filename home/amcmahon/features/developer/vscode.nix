{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    package = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: {
      src = (builtins.fetchTarball {
        url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
        sha256 = "sha256:0kcnis32gnclbzvcbinvdl2abgbjisqkzg9h6p97vsswaz2y8wd3";
      });
      version = "latest";
    });

    extensions = with pkgs.vscode-extensions; [
      zxh404.vscode-proto3
      redhat.vscode-yaml
      llvm-vs-code-extensions.vscode-clangd
      twxs.cmake
      donjayamanne.githistory
      jnoortheen.nix-ide
      mkhl.direnv
      serayuzgur.crates
      tamasfe.even-better-toml
      hashicorp.terraform
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      github.vscode-github-actions
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "cpptools";
        publisher = "ms-vscode";
        version = "1.20.5";
        sha256 = "sha256-vxY9hXTk1nu2FfsJOjtENnA9jGW709ujRHNPknbovFg=";
      }
      {
        name = "cmake-tools";
        publisher = "ms-vscode";
        version = "1.18.33";
        sha256 = "sha256-CAIzeOx1nprn2AUp4ND4dTXACiV40xgHyS/vcuOmeus=";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2024.7.11241010";
        sha256 = "sha256-ZbHTJBKSXkJ1abX1EnXKnFnPvKPhI1U+qkhRyyBkvr4=";
      }
      {
        name = "debugpy";
        publisher = "ms-python";
        version = "2024.6.0";
        sha256 = "sha256-VlPe65ViBur5P6L7iRKdGnmbNlSCwYrdZAezStx8Bz8=";
      }
    ];

    userSettings = {
      "update.mode" = "none";
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
