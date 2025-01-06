# nixos-config
This is my nixos configuration, which i use for my own purposes.

# Preparation
You have to setup the partition layout first with disko (see: https://github.com/nix-community/disko/).

# Install
Simply run the following command:
```
# nixos-rebuild reboot --flake /path/to/nixos-config#<chooseASystemFromFlake.nix>
or
# nixos-rebuild reboot --flake https://github.com/qw3rtz/nixos-config#<chooseASystemFromFlake.nix>
```
Or if nixos is not yet installed on target:
```
# nixos-install --flake /path/to/nixos-config#<chooseASystemFromFlake.nix> --root /target/root/path
or
# nixos-install --flake https://github.com/qw3rtz/nixos-config#<chooseASystemFromFlake.nix> --root /target/root/path
```
