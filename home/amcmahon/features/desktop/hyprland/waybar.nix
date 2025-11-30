{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.theme) colors font;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = false;
        passthrough = false;
        height = 28;
        margin = "1";
        position = "top";
        layer = "top";

        modules-left = [
          "custom/menu"
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
        ];

        "custom/menu" = {
          format = " ";
          tooltip = false;
          on-click = "wofi --show drun";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            urgent = "";
            active = "";
            default = "";
          };
          persistent_workspaces = {
            "*" = 5;
          };
        };

        "hyprland/submap" = {
          format = "<span style=\"italic\">{}</span>";
          max-length = 20;
          tooltip = false;
        };

        clock = {
          interval = 60;
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='${colors.primary}'><b>{}</b></span>";
              days = "<span color='${colors.foreground}'><b>{}</b></span>";
              weeks = "<span color='${colors.secondary}'><b>W{}</b></span>";
              weekdays = "<span color='${colors.warning}'><b>{}</b></span>";
              today = "<span color='${colors.urgent}'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "${lib.getExe pkgs.pavucontrol}";
        };

        network = {
          format-wifi = " {essid}";
          format-ethernet = " {ifname}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%): {ipaddr}/{cidr}";
          on-click = "${lib.getExe pkgs.networkmanagerapplet}";
        };

        cpu = {
          interval = 10;
          format = " {usage}%";
          tooltip = false;
        };

        memory = {
          interval = 30;
          format = " {}%";
          tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
        };
      };
    };

    style = ''
      * {
        font-family: "${font.name}";
        font-size: ${toString font.size}pt;
        font-weight: bold;
        border-radius: 0;
        border: none;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      #submap,
      #clock,
      #tray,
      #pulseaudio,
      #network,
      #cpu,
      #memory {
        background: ${colors.surface0};
        color: ${colors.foreground};
        padding: 0 12px;
        margin: 6px 4px;
        border-radius: 8px;
      }

      #custom-menu {
        background: ${colors.surface0};
        color: ${colors.foreground};
        font-size: 18pt;
        padding: 0 12px;
        margin: 6px 4px;
        border-radius: 8px;
        transition: all 0.3s ease-in-out;
      }

      #custom-menu:hover {
        background: ${colors.surface1};
      }

      #workspaces {
        background: ${colors.surface0};
        padding: 0 4px;
        margin: 6px 4px;
        border-radius: 8px;
      }

      #workspaces button {
        padding: 0 8px;
        color: ${colors.foreground};
        background: ${colors.surface0};
        border-radius: 8px;
        transition: all 0.3s ease-in-out;
      }

      #workspaces button:hover {
        background: ${colors.surface1};
      }

      #workspaces button.active {
        color: ${colors.primary};
        background: ${colors.surface0};
      }

      #workspaces button.urgent {
        color: ${colors.background};
        background: ${colors.urgent};
      }

      #submap {
        color: ${colors.warning};
      }

      #clock {
        color: ${colors.primary};
      }

      #pulseaudio {
        color: ${colors.success};
      }

      #pulseaudio.muted {
        color: ${colors.urgent};
      }

      #network {
        color: ${colors.secondary};
      }

      #network.disconnected {
        color: ${colors.urgent};
      }

      #cpu {
        color: ${colors.warning};
      }

      #memory {
        color: ${colors.secondary};
      }

      tooltip {
        background: ${colors.surface0};
        border: 2px solid ${colors.primary};
        border-radius: 8px;
      }

      tooltip label {
        color: ${colors.foreground};
      }
    '';
  };
}
