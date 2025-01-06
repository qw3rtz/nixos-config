let
  fontsize = "8"; # "12";
  primary_accent = "61ffef"; #"cba6f7";
  #secondary_accent = "89b4fa";
  #tertiary_accent = "f5f5f5";
  background = "11111B";
  opacity = "1.0"; #".8";
  cursor = "Catppuccin-Mocha-Dark-Cursors";

in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      monitor = [
      #  # name,resolution,position,scale
      #  # position can be negative to swtich monitor to the left or right side
        "DP-1,1440x900@59.75,560x-900,1"
        "DP-3,2560x1440@164.78,0x0,1"
        "HDMI-A-1,1920x1080@59.96,-1920x360,1"
      ];
      exec-once = [
        #"waybar" # already started by env
        "xrandr --output DP-3 --primary" # set primary monitor to fix some issues with proton games
        "swaybg -i ~/Pictures/wallpapers/wallpaper.png"
        "hyprctl setcursor ${cursor} ${fontsize}" # not working yet
        "swaync"
        "easyeffects -q --gapplication-service &"
      ];
      xwayland = {
        force_zero_scaling = true; 
      };
      input = {
        kb_layout = "us";
        kb_variant = "altgr-intl";
        kb_options = "ctrl:nocaps";
        follow_mouse = true;
        force_no_accel = 1;
        touchpad = {
          natural_scroll = 1;
        };
      };
      general = {
        gaps_in = 2; #4;
        gaps_out = 5; #10;
        border_size = 2;#2;
        "col.active_border" = "rgb(${primary_accent})";
        "col.inactive_border" = "rgba(${background}00)";
        allow_tearing = true;
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        shadow_ignore_window = true;
        drop_shadow = true;
        shadow_range = 50;
        shadow_render_power = 3;
        # "col.shadow" = "rgb(${primary_accent})";
        "col.shadow" = "rgba(${primary_accent}00)";
        "col.shadow_inactive" = "rgba(${background}00)";
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          noise = 0.0117;
          contrast = 1.2;
          xray = false;
          brightness = 1;
        };
      };
      animations = {
        enabled = true;
        bezier = [ "easeinoutsine, 0.37, 0, 0.63, 1" ];
        animation = [ 
          "windows,1,2,easeinoutsine,slide" 
          "border,1,10,default"
          "fade,1,1,default"
          "workspaces,1,1,easeinoutsine,slide"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };
      master = {
        new_status = "slave";
      };
      gestures = {
        workspace_swipe = false;
      };
      misc = {
        vrr = 1;
        disable_hyprland_logo  = true;
        disable_splash_rendering = true;
      };
      bind = [
        # Exit to tty
        "$mainMod SHIFT, X, exit "
        # Launch
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, D, exec, wofi"
        #''$mainMod,P,exec,IMG=~/photos/screenshots/$(date +%Y-%m-%d_%H-%m-%s).png && mkdir -p ~/photos/screenshots && grim -g "$(slurp -d)" $IMG && wl-copy < $IMG; notify-send -i $IMG Screenshot "Screenshot saved to ''${IMG} and copied to clipboard"''
        "$mainMod ,N,exec, swaync-client -t -sw"
        "$mainMod SHIFT,M,exec, hyprlock --immediate"
        # Window Options
        "$mainMod, V, pseudo"
        "$mainMod, W, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod, E, togglefloating "
        "$mainMod SHIFT, Q, killactive"
        # Focus Windows
        "$mainMod, LEFT, movefocus, l"
        "$mainMod, RIGHT, movefocus, r"
        "$mainMod, UP, movefocus, u"
        "$mainMod, DOWN, movefocus, d"
        # Move Windows
        "$mainMod SHIFT,LEFT,movewindow,l"
        "$mainMod SHIFT,RIGHT,movewindow,r"
        "$mainMod SHIFT,UP,movewindow,u"
        "$mainMod SHIFT,DOWN,movewindow,d"
        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        # Switch active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        # Scroll workspace with mouse scrollwheel
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        # OBS
        "CTRL SHIFT, S, pass,^(com\.obsproject\.Studio)$"
      ];
      bindm = [
        # Move and resize windows with mouse too
        "$mainMod, mouse:272, movewindow"
        "$mainMod SHIFT, mouse:272, resizewindow"
      ];
      bindle = [
        # Backlight Keys
        ",XF86MonBrightnessUp,exec,light -A 5"
        ",XF86MonBrightnessDown,exec,light -U 5"
        # Volume Keys
        ",XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%  "
        ",XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%  "
      ];
      bindl = [
        ",switch:Lid Switch, exec, hyprlock --immediate"
      ];
      windowrulev2 = [
        "opacity ${opacity} ${opacity},class:^(thunar)$"
        #"opacity 0.90 0.90,class:^(Brave-browser)$"
        #"opacity 0.90 0.90,class:^(brave-browser)$"
        "opacity ${opacity} ${opacity},class:^(firefox)$"
        #"opacity ${opacity} ${opacity},class:^(discord)$"
        "opacity ${opacity} ${opacity},class:^(vesktop)$"
        #"opacity ${opacity} ${opacity},class:^(gnome-calculator)$" # not working
        #"opacity ${opacity} ${opacity},class:^(easyeffects)$" # not working
        #"opacity ${opacity} ${opacity},class:^(file-roller)$" # not working 
        #"opacity ${opacity} ${opacity},class:^(blueman-manager)$" # not working
        #"opacity ${opacity} ${opacity},class:^(spotify)$" # not working
        #"opacity ${opacity} ${opacity},class:^(kitty)$" # setted by kitty config
        "float,class:^(pavucontrol)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float,title:^(mpv)$"
        # Ensure tearing for specific games
        # All games run with gamescope
        "immediate, class:^(.gamescope-wrapped)$" 
      ];
      layerrule = [
        "blur, waybar"
        "blur, wofi"
        "ignorezero, wofi"
      ];
    };
    # Submaps
    extraConfig = ''
      # will switch to a submap called resize
      bind=$mainMod,R,submap,resize

      # will start a submap called "resize"
      submap=resize

      # sets repeatable binds for resizing the active window
      binde=,L,resizeactive,15 0
      binde=,H,resizeactive,-15 0
      binde=,K,resizeactive,0 -15
      binde=,J,resizeactive,0 15

      # use reset to go back to the global submap
      bind=,escape,submap,reset 
      bind=$mainMod,R,submap,reset

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # For tearing
      #env = WLR_DRM_NO_ATOMIC,1 # FIXME: needed?
    '';
  };
}
