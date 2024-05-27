{ lib, config, pkgs, ... }: {
  imports = [
    ../common
    ../wayland
    ../wayland-term
    ./basic-binds.nix
    ./mako.nix
    ./swaylock.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
  ];

  home.sessionVariables = {
    LIBSEAT_BACKEND = "logind";
    QT_QPA_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "va_gl";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  home.packages = with pkgs; [
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
    };

    settings =
      let
        active = "0xaa${config.colorscheme.palette.base0C}";
        inactive = "0xaa${config.colorscheme.palette.base02}";
      in
      {
        general = {
          gaps_in = 1;
          gaps_out = 1;
          "col.active_border" = active;
          "col.inactive_border" = inactive;
        };
        group = {
          "col.border_active" = active;
          "col.border_inactive" = inactive;
          groupbar.font_size = 11;
        };
        binds = {
          movefocus_cycles_fullscreen = false;
        };
        input = {
          kb_layout = "gb";
          touchpad.disable_while_typing = false;
        };
        dwindle = {
          split_width_multiplier = 1.35;
          pseudotile = true;
        };
        misc = {
          vrr = 2;
          focus_on_activate = true;
        };
        windowrulev2 =
          let
            steam = "title:^()$,class:^(steam)$";
          in
          [
            "stayfocused, ${steam}"
            "minsize 1 1, ${steam}"
          ];
        layerrule = [
          "blur,waybar"
          "ignorezero,waybar"
        ];

        decoration = {
          active_opacity = 0.97;
          inactive_opacity = 0.77;
          fullscreen_opacity = 1.0;
          rounding = 7;
          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            new_optimizations = true;
            ignore_opacity = true;
          };
          drop_shadow = true;
          shadow_range = 12;
          shadow_offset = "3 3";
          "col.shadow" = "0x44000000";
          "col.shadow_inactive" = "0x66000000";
        };
        animations = {
          enabled = true;
          bezier = [
            "easein,0.11, 0, 0.5, 0"
            "easeout,0.5, 1, 0.89, 1"
            "easeinback,0.36, 0, 0.66, -0.56"
            "easeoutback,0.34, 1.56, 0.64, 1"
          ];

          animation = [
            "windowsIn,1,3,easeoutback,slide"
            "windowsOut,1,3,easeinback,slide"
            "windowsMove,1,3,easeoutback"
            "workspaces,1,2,easeoutback,slide"
            "fadeIn,1,3,easeout"
            "fadeOut,1,3,easein"
            "fadeSwitch,1,3,easeout"
            "fadeShadow,1,3,easeout"
            "fadeDim,1,3,easeout"
            "border,1,3,easeout"
          ];
        };

        exec-once = [
          "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"
          "${pkgs.waybar}/bin/waybar"
        ];

        bind =
          let
            swaylock = "${config.programs.swaylock.package}/bin/swaylock";
            playerctl = "${config.services.playerctld.package}/bin/playerctl";
            playerctld = "${config.services.playerctld.package}/bin/playerctld";
            makoctl = "${config.services.mako.package}/bin/makoctl";
            wofi = "${config.programs.wofi.package}/bin/wofi";

            wpctl = "${pkgs.pulseaudio}/bin/wpctl";

            gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
            xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
            defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

            terminal = config.home.sessionVariables.TERMINAL;
            browser = defaultApp "x-scheme-handler/https";
            editor = defaultApp "text/plain";
          in
          [
            # Program bindings
            "SUPER,Return,exec,${terminal}"
            "SUPER,e,exec,${editor}"
            "SUPER,v,exec,${editor}"
            "SUPER,b,exec,${browser}"
            # Volume
            ",XF86AudioRaiseVolume,exec,${wpctl} set-sink-volume @DEFAULT_SINK@ +5%"
            ",XF86AudioLowerVolume,exec,${wpctl} set-sink-volume @DEFAULT_SINK@ -5%"
            ",XF86AudioMute,exec,${wpctl} set-sink-mute @DEFAULT_SINK@ toggle"
            "SHIFT,XF86AudioMute,exec,${wpctl} set-source-mute @DEFAULT_SOURCE@ toggle"
            ",XF86AudioMicMute,exec,${wpctl} set-source-mute @DEFAULT_SOURCE@ toggle"
          ] ++
          # Media control
          (lib.optionals config.services.playerctld.enable [
            ",XF86AudioNext,exec,${playerctl} next"
            ",XF86AudioPrev,exec,${playerctl} previous"
            ",XF86AudioPlay,exec,${playerctl} play-pause"
            ",XF86AudioStop,exec,${playerctl} stop"
            "ALT,XF86AudioNext,exec,${playerctld} shift"
            "ALT,XF86AudioPrev,exec,${playerctld} unshift"
            "ALT,XF86AudioPlay,exec,systemctl --user restart playerctld"
          ]) ++
          # Screen lock
          (lib.optionals config.programs.swaylock.enable [
            ",XF86Launch5,exec,${swaylock} -S --grace 2"
            ",XF86Launch4,exec,${swaylock} -S --grace 2"
            "SUPER,backspace,exec,${swaylock} -S --grace 2"
          ]) ++
          # Notification manager
          (lib.optionals config.services.mako.enable [
            "SUPER,w,exec,${makoctl} dismiss"
          ]) ++
          # Launcher
          (lib.optionals config.programs.wofi.enable [
            "SUPER,x,exec,${wofi} -S drun -x 10 -y 10 -W 25% -H 60%"
            "SUPER,d,exec,${wofi} -S run"
          ]);

        monitor = map
          (m:
            let
              resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
              position = "${toString m.x}x${toString m.y}";
            in
            "${m.name},${if m.enabled then "${resolution},${position},1" else "disable"}"
          )
          (config.monitors);

        workspace = map
          (m:
            "${m.name},${m.workspace}"
          )
          (lib.filter (m: m.enabled && m.workspace != null) config.monitors);
      };
  };
}
