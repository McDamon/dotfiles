{ pkgs, config, lib, ... }:
let
  inherit (config.colorscheme) colors;
in
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "base16-themes";
        publisher = "AndrsDC";
        version = "1.4.5";
        sha256 = "0qxxhhjr2hj60spy7cv995m1px5z6m2syhxsnfl1wj2aqkwp32cs";
      }
      {
        name = "githistory";
        publisher = "donjayamanne";
        version = "0.6.20";
        sha256 = "0x9q7sh5l1frpvfss32ypxk03d73v9npnqxif4fjwcfwvx5mhiww";
      }
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.2.1";
        sha256 = "0bibb3r4cb7chnx6vpyl41ig12pc0cbg0sb8f2khs52c71nk4bn8";
      }
      {
        name = "direnv";
        publisher = "mkhl";
        version = "0.12.1";
        sha256 = "0lizp7r2l6dayhvxkz3ghsgywz9magvy7lzkc5dkcqxcsi1p4klb";
      }
      {
        name = "rust-analyzer";
        publisher = "rust-lang";
        version = "0.4.1521";
        sha256 = "1a0rx0i2irqjp85yh413kyax7bbrdk5gcbapm37j383zdw9fdd37";
      }
    ];
    userSettings = {
      "window.titleBarStyle" = "custom";
      "git.autofetch" = true;
      "terminal.integrated.fontFamily" = "${config.fontProfiles.monospace.family}";
      "editor.fontFamily" = "${config.fontProfiles.monospace.family}";
      "editor.fontLigatures" = true;
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "terminal.integrated.minimumContrastRatio" = 1;
      "terminal.integrated.gpuAcceleration" = "canvas";
      "terminal.integrated.shellIntegration.enabled" = true;
      "workbench.colorCustomizations" = {
        "terminal.background" = "#1B1918";
        "terminal.foreground" = "#A8A19F";
        "terminalCursor.background" = "#A8A19F";
        "terminalCursor.foreground" = "#A8A19F";
        "terminal.ansiBlack" = "#1B1918";
        "terminal.ansiBlue" = "#407EE7";
        "terminal.ansiBrightBlack" = "#766E6B";
        "terminal.ansiBrightBlue" = "#407EE7";
        "terminal.ansiBrightCyan" = "#3D97B8";
        "terminal.ansiBrightGreen" = "#7B9726";
        "terminal.ansiBrightMagenta" = "#6666EA";
        "terminal.ansiBrightRed" = "#F22C40";
        "terminal.ansiBrightWhite" = "#F1EFEE";
        "terminal.ansiBrightYellow" = "#C38418";
        "terminal.ansiCyan" = "#3D97B8";
        "terminal.ansiGreen" = "#7B9726";
        "terminal.ansiMagenta" = "#6666EA";
        "terminal.ansiRed" = "#F22C40";
        "terminal.ansiWhite" = "#A8A19F";
        "terminal.ansiYellow" = "#C38418";
      };
      "workbench.colorTheme" = "Base16 Atelier Forest";
    };
  };
}
