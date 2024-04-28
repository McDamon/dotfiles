{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    package = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: {
      src = (builtins.fetchTarball {
        url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
        sha256 = "sha256:0q2i189rqyi6m6j0jxhg6z6nb5l6kf9sl51cjhjc4y1s8ayfkcz3";
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
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "cpptools";
        publisher = "ms-vscode";
        version = "1.20.2";
        sha256 = "sha256-wpaSzYNwMGZ6T1LFbiwpF5koY5y1MDQuNXBosMn12cY=";
      }
      {
        name = "cmake-tools";
        publisher = "ms-vscode";
        version = "1.18.30";
        sha256 = "sha256-KDTipUL/Vbd1PJ0GMrUYjWJ6XAW221aRxAIPGdBInQw=";
      }
      {
        name = "python";
        publisher = "ms-python";
        version = "2024.5.11141012";
        sha256 = "sha256-lwjozafL3IQwxmFTzA2OFQo1bC3NCoBKPrr3kpgASMY=";
      }
      {
        name = "debugpy";
        publisher = "ms-python";
        version = "2024.5.11141010";
        sha256 = "sha256-TFo+/SISPFacRcHMvz5aBP85j3MYwkG+4zBzt3vk4AI=";
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
