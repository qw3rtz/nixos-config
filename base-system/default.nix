{ pkgs, lib, inputs, ... }:
{
  imports =
    [
      ./pkgs.nix
      ./locale.nix
      ./persistence.nix
      ./root.nix
      ./docker.nix
    ];
  
  # do not modify!
  system.stateVersion = "24.05";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us"; # already set
    useXkbConfig = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      # disabled for now
      #packageOverrides = pkgs: {
      #  unstable = import unstableTarball {
      #    config = config.nixpkgs.config;
      #  };
      #};
    };
  }; 

  services.openssh.enable = true;
  services.printing.enable = true;
}
