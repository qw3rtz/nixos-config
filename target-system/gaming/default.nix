{ ... }:
{
  imports = [
    ./pkgs.nix
    ./audio.nix
    ./bluetooth.nix
    ./libvirt.nix
    ./steam.nix
    ./uinput.nix
    ./window-manager.nix
    ./orca-slicer.nix
  ];

  programs.nix-ld.enable = true;
}
