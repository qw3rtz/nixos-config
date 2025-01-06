{ pkgs, lib, inputs, ... }:
{
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
   # hideMounts = true; 
    directories = [
      "/etc/nixos"
     # "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/docker"
      "/var/lib/libvirt"
     # "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
     # { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
     # { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };
}
