{ pkgs, ... }:
{
programs.waybar = {
	enable = true;
	package = pkgs.waybar;
	settings = {
        mainBar = {
            height = 14;
            layer = "top";
            #modules-left = ["custom/launcher" "cpu" "memory" "custom/weather" "hyprland/workspaces"];
            #modules-center = ["mpris"];
            #modules-right = ["network" "pulseaudio" "backlight" "battery" "clock" "tray" "hyprland/language" "custom/wallpaper" "custom/power-menu"];
            modules-left = ["custom/launcher" "cpu" "memory" "temperature#cpuedge" "temperature#gpuedge"];
            modules-center = ["mpris"];
            modules-right = ["tray" "network" "custom/pipewire" "bluetooth" "clock" "hyprland/language"];

          "hyprland/workspaces" = {
            format = "{name}";
            all-outputs = true;
            on-click = "activate";
            format-icons = {
              active = " 󱎴";
              default = "󰍹";
            };
            persistent-workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
              "5" = [];
              "6" = [];
              "7" = [];
              "8" = [];
              "9" = [];
            };
          };
          "hyprland/language" = {
            format = "{short}";
          };

          "hyprland/window" = {
            max-length = 200;
            separate-outputs = true;
          };
          "tray" = {
            spacing = 10;
          };
          "clock" = {
            format = "{:%H:%M}";
            format-alt = "{:%b %d %Y}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          "cpu" = {
            interval = 10;
            format = "  {}%";
            max-length = 10;
            on-click = "";
          };
          "memory" = {
            interval = 30;
            format = " {}%";
            format-alt = " {used:0.1f}GB";
            max-length = 10;
          };
          # gpu mem temp
          "temperature#gpumem" = {
            interval = 10;
            hwmon-path = "/sys/class/hwmon/hwmon0/temp3_input";
            format = " gpumem: {temperatureC}°C";
            max-length = 10;
          };
          # gpu junction temp
          "temperature#gpujun" = {
            interval = 10;
            hwmon-path = "/sys/class/hwmon/hwmon0/temp2_input";
            format = " gpujun: {temperatureC}°C";
            max-length = 10;
          };
          # gpu edge temp
          "temperature#gpuedge" = {
            interval = 10;
            hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
            format = "GPU:{temperatureC}°C";
            max-length = 10;
          };
          # cpu edge temp
          "temperature#cpuedge" = {
            interval = 10;
            hwmon-path = "/sys/class/hwmon/hwmon3/temp3_input";
            format = "CPU:{temperatureC}°C";
            max-length = 10;
          };
          # cpu junction temp
          # TODO: determine per label (symlinking?)
          "temperature#cpujun" = {
            interval = 10;
            hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
            format = " cpujun: {temperatureC}°C";
            max-length = 10;
          };
          "backlight" = {
            device = "intel_backlight";
            format = "{icon}";
            tooltip = true;
            format-alt = "<small>{percent}%</small>";
            format-icons = ["󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
            on-scroll-up = "brightnessctl set 1%+";
            on-scroll-down = "brightnessctl set 1%-";
            smooth-scrolling-threshold = "2400";
            tooltip-format = "Brightness {percent}%";
          };
          "network" = {
            format-wifi = "<small>{bandwidthDownBytes}</small> {icon}";
            min-length = 10;
            fixed-width = 10;
            format-ethernet = "󰈀";
            format-disconnected = "󰤭";
            tooltip-format = "{essid}";
            interval = 1;
            on-click = "~/.config/waybar/scripts/network/rofi-network-manager.sh";
            format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          };

          "bluetooth" = {
            format = "{icon}";
            format-alt = "bluetooth: {status}";
            interval = 30;
            format-icons = {
              enabled = "";
              disabled = "󰂲";
            };
            tooltip-format = "{status}";
          };

          # FIXME: icon disappears
          "custom/pipewire" = {
            exec = "pw-volume status";
            return-type = "json";
            interval = 10;  #"once";
            signal = 8;
            format = "{icon} {percentage}%";
            format-icons = {
                mute = "󰖁";
                default = ["󰕿" "󰖀" "󰕾"];
            };
            on-click = "pw-volume mute toggle";
            on-scroll-up = "pw-volume change +2.5%";
            on-scroll-down = "pw-volume change -2.5%";
            on-click-right = "exec easyeffects";
            tooltip-format = "Volume {percentage}%";
          };

          "battery" = {
            bat = "BAT0";
            adapter = "ADP0";
            interval = 60;
            states = {
              warning = 20;
              critical = 15;
            };
            max-length = 20;
            format = "{icon}";
            format-warning = "{icon}";
            format-critical = "{icon}";
            format-charging = "<span font-family='Font Awesome 6 Free'></span>";
            format-plugged = "󰚥";
            format-notcharging = "󰚥";
            format-full = "󰂄";

            format-alt = "<small>{capacity}%</small> ";
            format-icons = ["󱊡" "󱊢" "󱊣"];
          };

          "custom/weather" = {
            exec = "nix-shell ~/.config/waybar/scripts/weather.py";
            restart-interval = 300;
            return-type = "json";
          };

          "mpris" = {
            format = "{player_icon} {title}";
            format-paused = " {status_icon} <i>{title}</i>";
            max-length = 80;
            player-icons = {
              default = "▶";
              mpv = "🎵";
            };
            status-icons = {
              paused = "⏸";
            };
          };

          "custom/spotify" = {
            exec = "nix-shell ~/.config/waybar/scripts/mediaplayer.py --player youtube-music";
            format = " {}";
            return-type = "json";
            on-click = "playerctl play-pause";
            on-double-click-right = "playerctl next";
            on-scroll-down = "playerctl previous";
          };

          "custom/power-menu" = {
            format = "{percentage}Hz";
            on-click = "~/.config/hypr/scripts/screenHz.sh";
            return-type = "json";
            exec = "cat ~/.config/hypr/scripts/hz.json";
            interval = 1;
            tooltip = false;
          };

          "custom/launcher" = {
            format = "󱄅";
            #on-click = "rofi -show drun &";
            on-click = "wofi &";
          };

          "custom/wallpaper" = {
            format = "󰸉";
            on-click = "bash ~/.config/waybar/scripts/changewallpaper.sh";
          };
          };
          };
        style = '' 
                  * {
            /* `otf-font-awesome` is required to be installed for icons */
            font-family: Material Design Icons, JetBrainsMono Nerd Font, Iosevka Nerd Font ;
            font-size: 14px;
            border: none;
            border-radius: 0;
            min-height: 0;
          }

          window#waybar {
            background-color: rgba(26, 27, 38, 0.5);
            color: #ffffff;
            transition-property: background-color;
            transition-duration: 0.5s;
          }

          window#waybar.hidden {
            /* opacity: 0.7; */
            opacity: 1.0;
          }

          #window {
            color: #64727d;
          }

          #clock,
          #temperature,
          #mpris, 
          #cpu,
          #memory,
          #custom-media,
          #tray,
          #mode,
          #bluetooth,
          #battery,
          #backlight,
          #language,
          #network,
          #custom-pipewire,
          #custom-lock,
          #workspaces,
          #idle_inhibitor,
          #custom-launcher,
          #custom-spotify,
          #custom-weather,
          #custom-weather.severe,
          #custom-weather.sunnyDay,
          #custom-weather.clearNight,
          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight,
          #custom-weather.rainyDay,
          #custom-weather.rainyNight,
          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight,
          #custom-weather.default {
            color: #e5e5e5;
            border-radius: 6px;
            padding: 2px 10px;
            background-color: #252733;
            border-radius: 8px;
            font-size: 12px;

            margin-left: 4px;
            margin-right: 4px;

            margin-top: 8.5px;
            margin-bottom: 8.5px;
          }
          #temperature{
            color: #7a95c9;
          }
          #cpu {
            color: #fb958b;
          }

          #memory {
            color: #a1c999;
          }

          #workspaces button {
            color: #7a95c9;
            box-shadow: inset 0 -3px transparent;

            padding-right: 3px;
            padding-left: 4px;

            margin-left: 0.1em;
            margin-right: 0em;
            transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
          }

          #workspaces button.active {
            color: #ecd3a0;
            padding-left: 1px;
            padding-right: 5px;
            font-family: Iosevka Nerd Font;
            font-weight: bold;
            font-size: 12px;
            margin-left: 0em;
            margin-right: 0em;
            transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
          }

          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
          }

          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
          }

          #custom-launcher {
            margin-left: 12px;

            padding-right: 18px;
            padding-left: 14px;

            font-size: 16px;

            color: #7a95c9;

            margin-top: 8.5px;
            margin-bottom: 8.5px;
          }
          
          #custom-pipewire {
            color: #81A1C1;
          }

          #pulseaudio {
            color: #81A1C1;
          }

          #pulseaudio.muted {
            color: #fb958b;
          }

          #backlight {
            color: #ecd3a0;
          }

          #network {
            color: #5E81AC;
          }

          #network.disconnected {
            color: #fb958b;
          }

          #bluetooth {
            color: #5E81AC;
            font-size: 16px;
          }

          #bluetooth.disconnected {
            color: #fb958b;
            font-size: 16px;
          }


          #battery {
            color: #8fbcbb;
          }

          #battery.critical,
          #battery.warning,
          #battery.full,
          #battery.plugged {
            color: #8fbcbb;
          }

          #battery.charging { 
            font-size: 18px;
          }

          #battery.full,
          #battery.plugged {
            font-size: 15.5px;
          }

          @keyframes blink {
            to {
              background-color: rgba(30, 34, 42, 0.5);
              color: #abb2bf;
            }
          }

          #battery.warning {
            color: #ecd3a0;
          }

          #battery.critical:not(.charging) {
            color: #fb958b;
          }

          #custom-lock {
            color: #ecd3a0;
            padding: 0 15px 0 15px;
            margin-left: 7px;
            margin-top: 7px;
            margin-bottom: 7px;
          }
          #clock {
            color: #8a909e;
            font-family: Iosevka Nerd Font;
            font-weight: bold;
            margin-top: 7px;
            margin-bottom: 7px;
          }
          #language {
            color: #8a909e;
            font-family: Iosevka Nerd Font;
            font-weight: bold;
            border-radius : 8px 8px 8px 8px;
            margin-top: 7px;
            margin-bottom: 7px;
            margin-right: 12px;
          }

          #custom-power-menu {
            color: #8a909e;
            margin-right: 12px;
            border-radius: 8px;
            padding: 0 6px 0 6.8px;
            border-radius: 0 8px 8px 0;
            margin-top: 7px;
            margin-bottom: 7px;
          }
          #custom-wallpaper {
            color: #8a909e;
            padding-right: 7;
            padding-left: 7;
          }
          #custom-wallpaper,
          #language,
          #custom-power-menu {
            background-color: #252733;
            padding: 0em 2em;

            font-size: 12px;

            padding-left: 7.5px;
            padding-right: 7.5px;

            padding-top: 3px;
            padding-bottom: 3px;

            margin-top: 7px;
            margin-bottom: 7px;
          }

          tooltip {
            font-family: Iosevka Nerd Font;
            border-radius: 15px;
            padding: 15px;
            background-color: #1f232b;
          }

          tooltip label {
            font-family: Iosevka Nerd Font;
            padding: 5px;
          }

          label:focus {
            background-color: #1f232b;
          }

          #tray {
            margin-right: 8px;
            margin-top: 7px;
            margin-bottom: 7px;
            font-size: 15px;

          }

          #tray > .passive {
            -gtk-icon-effect: dim;
          }

          #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
          }

          #idle_inhibitor {
            background-color: #242933;
          }

          #idle_inhibitor.activated {
            background-color: #ecf0f1;
            color: #2d3436;
          }
          #mpris,
          #custom-spotify {
            color: #abb2bf;
          }

          #custom-weather {
            font-family: Iosevka Nerd Font;
            font-size: 19px;
            color: #8a909e;
          }

          #custom-weather.severe {
            color: #eb937d;
          }

          #custom-weather.sunnyDay {
            color: #c2ca76;
          }

          #custom-weather.clearNight {
            color: #cad3f5;
          }

          #custom-weather.cloudyFoggyDay,
          #custom-weather.cloudyFoggyNight {
            color: #c2ddda;
          }

          #custom-weather.rainyDay,
          #custom-weather.rainyNight {
            color: #5aaca5;
          }

          #custom-weather.showyIcyDay,
          #custom-weather.snowyIcyNight {
            color: #d6e7e5;
          }

          #custom-weather.default {
            color: #dbd9d8;
          }
    '';
  };
}
