{
  pkgs,
  lib,
  config,
  ...
}:
let
  defaultApp = type: "${lib.getExe pkgs.handlr-regex} launch ${type}";

  # Convert hex color to rgba format for Hyprland
  hexToRgba =
    hex: alpha:
    let
      # Remove the # if present
      cleanHex = lib.removePrefix "#" hex;
      # Convert alpha to hex string (00-ff)
      alphaHex = lib.toLower (builtins.substring 0 2 (lib.toHexString (256 + alpha)));
    in
    "rgba(${cleanHex}${alphaHex})";
in
{
  imports = [
    ../common
    ../wayland
    ./basic-binds.nix
    ./mako.nix
    ./waybar.nix
    ./wofi.nix
    ./theme.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = hexToRgba config.theme.colors.border 255;
        "col.inactive_border" = hexToRgba config.theme.colors.borderInactive 255;
        resize_on_border = true;
        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 8;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          xray = true;
        };

        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      input = {
        kb_layout = "gb";
        follow_mouse = 1;
        sensitivity = 0;
        accel_profile = "flat";
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = false;
        smart_resizing = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        vrr = 1;
        focus_on_activate = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };

      # Window rules
      windowrulev2 = [
        # Picture-in-Picture
        "float,title:^(Picture-in-Picture)$"
        "pin,title:^(Picture-in-Picture)$"
        "size 25% 25%,title:^(Picture-in-Picture)$"
        "move 74% 74%,title:^(Picture-in-Picture)$"

        # File pickers
        "float,title:^(Open File)$"
        "float,title:^(Save File)$"
        "size 60% 60%,title:^(Open File)$"
        "size 60% 60%,title:^(Save File)$"
        "center,title:^(Open File)$"
        "center,title:^(Save File)$"

        # Thunar
        "float,class:^(thunar)$,title:^(File Operation Progress)$"

        # 1Password
        "float,class:^(1Password)$"
        "center,class:^(1Password)$"
        "size 60% 70%,class:^(1Password)$"

        # Opacity rules
        "opacity 0.95 0.85,class:^(kitty)$"
        "opacity 0.95 0.85,class:^(thunar)$"
        "opacity 1.0 1.0,class:^(firefox)$"
        "opacity 1.0 1.0,class:^(chromium)$"

        # Workspace assignments (examples)
        "workspace 2 silent,class:^(firefox)$"
        "workspace 3 silent,class:^(code)$"
      ];

      # Startup applications
      exec-once = [
        # Environment setup
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # SSH_AUTH_SOCK points to 1Password agent socket (configured in terminal.nix)
        # KWallet does NOT provide SSH agent, so no conflict!
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP SSH_AUTH_SOCK"

        # KWallet is started automatically by PAM at login, no need to start it here

        # Polkit authentication agent (handles privilege escalation for 1Password and other apps)
        "${lib.getExe' pkgs.kdePackages.polkit-kde-agent-1 "polkit-kde-authentication-agent-1"}"

        # UI components (waybar started by systemd)

        # 1Password (uses KWallet for session persistence, provides SSH agent via ~/.1password/agent.sock)
        "1password --silent"
      ];

      monitor =
        let
          waybarSpace =
            let
              inherit (config.wayland.windowManager.hyprland.settings.general) gaps_out;
              inherit (config.programs.waybar.settings.primary) position height width;
            in
            {
              top = if (position == "top") then height + gaps_out + 4 else 0;
              bottom = if (position == "bottom") then height + gaps_out else 0;
              left = if (position == "left") then width + gaps_out else 0;
              right = if (position == "right") then width + gaps_out else 0;
            };
        in
        [
          ",addreserved,${toString waybarSpace.top},${toString waybarSpace.bottom},${toString waybarSpace.left},${toString waybarSpace.right}"
        ]
        ++ (map (
          m:
          let
            baseConfig =
              if m.enabled then
                "${toString m.width}x${toString m.height}@${toString m.refreshRate},${m.position},${m.scale}"
              else
                "disable";
          in
          "${m.name},${baseConfig}"
        ) (config.monitors));

      # Normal bindings
      bind = [
        # Program bindings
        "SUPER,Return,exec,${defaultApp "x-scheme-handler/terminal"}"
        "SUPER,e,exec,${defaultApp "text/plain"}"
        "SUPER,b,exec,${defaultApp "x-scheme-handler/https"}"
        "SUPER,l,exec,${lib.getExe pkgs.hyprlock}"
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
            "SUPER,x,exec,${wofi} -S drun"
            "SUPER,s,exec,specialisation $(specialisation | ${wofi} -S dmenu)"
            "SUPER,d,exec,${wofi} -S run"
          ]
        );
    };
  };

  home.packages = with pkgs; [
    wofi
    xfce.thunar
    kdePackages.kwallet
    kdePackages.kwalletmanager # GUI for managing KWallet
  ];
}
