{ pkgs, inputs, ... }:

{ 
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./hyprland.nix
    ./waybar.nix
    ./theme.nix
    ./wofi.nix
    ./kitty.nix
  ];

  # do not modify!
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.persistence."/persist/home" = {
    directories = [
      #"Downloads"
      "Music"
      "Pictures"
      "Projects"
      "Documents"
      "Videos"
      "VMs"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/kicad"
      ".local/share/Terraria"
      ".local/share/orca-slicer"
      #".local/share/docker"
      ".config/discord"
      ".config/vesktop"
      ".config/OrcaSlicer"
      ".config/spotify"
      ".config/easyeffects"
      ".mozilla"
      ".cache"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".screenrc"
      ".bash_history"
      ".zsh_history"
      ".zshrc"
      ".bashrc"
    ];
    allowOther = true;
  };
}
