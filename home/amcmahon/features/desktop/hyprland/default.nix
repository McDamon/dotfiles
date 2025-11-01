{ pkgs, lib, config, ... }:
let
  defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";
in
{
  imports = [
    ../common
    ../wayland
    ./basic-binds.nix
    ./mako.nix
    ./waybar.nix
    ./wofi.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 15;
        gaps_out = 20;
        border_size = 2;
      };

      monitor =
        let
          waybarSpace =
            let
              inherit (config.wayland.windowManager.hyprland.settings.general) gaps_in gaps_out;
              inherit (config.programs.waybar.settings.primary) position height width;
              gap = gaps_out - gaps_in;
            in
            {
              top =
                if (position == "top")
                then height + gap
                else 0;
              bottom =
                if (position == "bottom")
                then height + gap
                else 0;
              left =
                if (position == "left")
                then width + gap
                else 0;
              right =
                if (position == "right")
                then width + gap
                else 0;
            };
        in
        [
          ",addreserved,${toString waybarSpace.top},${toString waybarSpace.bottom},${toString waybarSpace.left},${toString waybarSpace.right}"
        ]
        ++ (map
          (
            m: "${m.name},${
            if m.enabled
            then "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},${m.scale}"
            else "disable"
          }"
          )
          (config.monitors));

      # Normal bindings
      bind =
        [
          # Program bindings
          "SUPER,Return,exec,${defaultApp "x-scheme-handler/terminal"}"
          "SUPER,e,exec,${defaultApp "text/plain"}"
          "SUPER,b,exec,${defaultApp "x-scheme-handler/https"}"
        ]
        ++
        # Notification manager
        (
          let
            makoctl = lib.getExe' config.services.mako.package "makoctl";
          in
          lib.optionals config.services.mako.enable [
            "SUPER,w,exec,${makoctl} dismiss"
            "SUPERSHIFT,w,exec,${makoctl} restore"
          ]
        )
        ++
        # Launcher
        (
          let
            wofi = lib.getExe config.programs.wofi.package;
          in
          lib.optionals config.programs.wofi.enable [
            "SUPER,x,exec,${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
            "SUPER,s,exec,specialisation $(specialisation | ${wofi} -S dmenu)"
            "SUPER,d,exec,${wofi} -S run"
          ]
        );
    };
  };

  home.packages = with pkgs; [
    wofi
    xfce.thunar
  ];
}
