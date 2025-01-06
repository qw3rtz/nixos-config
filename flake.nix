{
  description = "Nixos config flake";
     
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.44.1";
    };
  };

  outputs = {nixpkgs, ...} @ inputs:
  {
    nixosConfigurations = { 
      # for testing purpose
      test = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.default
          (import ./disko.nix { device = "/dev/nvme0n1"; })

          ./configuration.nix
              
          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
        ];
      };

      # amd gaming tower
      gaming = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.default
          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          
          (import ./hardware/filesystem/tmpfs-root.nix { device = "/dev/nvme0n1"; })
          
          # hardware-layer config
          ./hardware/tux-tower/default.nix

          # base-layer config
          ./base-system/default.nix

          # system-layer config (applications)
          ./target-system/gaming/default.nix

          # user
          ./user/j0n5s/default.nix
        ];
      };

      # dell-notebook workstation
      work = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.default
          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          
          (import ./hardware/filesystem/tmpfs-root.nix { device = "/dev/nvme0n1"; })
          
          # hardware-layer config
          ./hardware/dell-notebook/default.nix

          # base-layer config
          ./base-system/default.nix

          # system-layer config (applications)
          ./target-system/workstation/default.nix

          # user
          ./user/jrau/default.nix
        ];
      };
    };
  };
}
