{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ../common
    ../wayland
    ./basic-binds.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
    };

    settings = {
      input = {
        kb_layout = "gb";
        touchpad.disable_while_typing = false;
      };
      misc = {
        vrr = 1;
      };

      exec = [
        "${pkgs.swaybg}/bin/swaybg -i ${config.wallpaper} --mode fill"
      ];

      bind =
        let
          swaylock = "${config.programs.swaylock.package}/bin/swaylock";
          playerctl = "${config.services.playerctld.package}/bin/playerctl";
          playerctld = "${config.services.playerctld.package}/bin/playerctld";
          makoctl = "${config.services.mako.package}/bin/makoctl";
          wofi = "${config.programs.wofi.package}/bin/wofi";
        
          grimblast = "${inputs.hyprland-contrib.packages.${pkgs.system}.grimblast}/bin/grimblast";
          tesseract = "${pkgs.tesseract}/bin/tesseract";

          pactl = "${pkgs.pulseaudio}/bin/pactl";
          notify-send = "${pkgs.libnotify}/bin/notify-send";

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
          ",XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
          ",XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
          ",XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle"
          "SHIFT,XF86AudioMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
          ",XF86AudioMicMute,exec,${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
          # Screenshotting
          ",Print,exec,${grimblast} --notify --freeze copy output"
          "SUPER,Print,exec,${grimblast} --notify --freeze copy area"
          # To OCR
          "ALT,Print,exec,${grimblast} --freeze save area - | ${tesseract} - - | wl-copy && ${notify-send} -t 3000 'OCR result copied to buffer'"
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
        ] ++ (lib.optionals config.programs.password-store.enable [
          ",Scroll_Lock,exec,${wofi}" # fn+k
          ",XF86Calculator,exec,${wofi}" # fn+f12
          "SUPER,semicolon,exec,pass-wofi"
        ]));

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
