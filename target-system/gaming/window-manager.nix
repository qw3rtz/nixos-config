{ pkgs, lib, inputs, ... }:
{
  # xdg portals
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
        #pkgs.xdg-desktop-portal-hyprland # FIXME: symlink error on build
      ];
    };
  };

  # security
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  # services
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "altgr-intl";
      excludePackages = [ pkgs.xterm ];
      videoDrivers = ["amdgpu"]; # TODO: move to base/hardwareconfig?
      displayManager.gdm = { # TODO: switch to sddm?
        enable = true;
        wayland = true;
      };
    };
    dbus.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    libinput.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "j0n5s";
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
  };
  
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  
  # wm programs
  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland = {
        #hidpi = true; # FIXME: deprecated in thise nixos version
        enable = true;
      };
    };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
    thunar = { # TODO: use ranger instead?
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    #kitty = { # FIXME: not working like that. is it really needed?
    #  enable = true;
    #};
  };
}
