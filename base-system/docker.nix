{ ... }:
{
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
    #rootless = {
    #  enable = true;
    #  setSocketVariable = true;
    #};
    # persisted trough persistence.nix
    #daemon = {
    #  settings = {
    #    data-root = "/persist/docker";
    #  };
    #};
  };
}
