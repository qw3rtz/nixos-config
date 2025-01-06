{ pkgs, ... }:
{
  gtk = {
      enable = true;
      font.name = "RobotoMono Nerd Font 12";
      iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.catppuccin-papirus-folders.override {
            flavor = "mocha";
            accent = "teal";
          };
      };
      cursorTheme = {
          name = "Catppuccin-Mocha-Dark-Cursors";
          package = pkgs.catppuccin-cursors.mochaDark;
      };
      theme = {
          name = "Adwaita-dark";
          package = pkgs.gnome.gnome-themes-extra;
      };
      gtk3.extraConfig = {
          Settings = ''
              gtk-application-prefer-dark-theme=1
              '';
      };
      gtk4.extraConfig = {
          Settings = ''
              gtk-application-prefer-dark-theme=1
              '';
      };
  };
  
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "gtk2";
  };
  
  # dark theme for gnome apps
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
