{ ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./networking.nix
      ./boot-loader.nix
    ];
}
