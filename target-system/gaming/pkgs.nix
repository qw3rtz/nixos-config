{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # gaming
    dxvk
    mangohud
    wine
    winetricks
    protontricks
    vulkan-tools
    gnutls
    openldap
    protonup
    libgpg-error
    freetype
    sqlite
    libxml2
    xml2
    SDL2
    # using flatpak version due to bugs
    steam 
    steam-run
    meson
    gamemode
    #amdvlk # already installed in hardware
    mesa

    # default
    vlc # music/video player
    pw-volume # volume changer for waybar
    mpv # music/video player
    swayimg # image viewer
    gnome.gnome-calculator # calculator
    kicad # circuit designing
    flameshot
    #gparted # FIXME: not working cause xauthority not found
    nix-ld
    python3
    bluez
    gnumake
    bluez-tools
    blueman
    pipewire
    easyeffects
    firefox-wayland
    spotify
    discord
    vesktop
    libnotify
    kitty
    kitty-themes 
    grim
    slurp
    swaybg
    hyprlock
    # swaylock-effects
    swaynotificationcenter
    wl-clipboard
    pavucontrol
    wofi
    playerctl
    catppuccin-papirus-folders
    catppuccin-gtk
    (nerdfonts.override { fonts = [ "FiraCode" ]; })

    # FIXME: remove double
    hyprland
    #hyprland-share-picker # FIXME: package does not exists
    hyprland-protocols
    wl-clipboard
    wayland
    waybar
    swayidle
    swaylock
    polkit_gnome
    libva-utils
    udiskie
    libnotify
    dunst
    gnome.file-roller # archive manager
    gnome.adwaita-icon-theme
    gnome-themes-extra
    gsettings-desktop-schemas
    swaynotificationcenter
    wlr-randr
    ydotool
    xdg-desktop-portal-hyprland
    hyprpaper
    rofi-wayland
    swww
    grim
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    nerdfonts
    roboto-mono
    font-awesome
  ];
}
