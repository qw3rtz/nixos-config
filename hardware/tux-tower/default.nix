{ ... }:
{
  imports =
    [
      ./pkgs.nix
      ./hardware-configuration.nix
      ./networking.nix
      ./boot-loader.nix
    ];
}
