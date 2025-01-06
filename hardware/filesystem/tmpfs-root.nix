{
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
}: {
  disko.devices = {
    # tmpfs on root
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = ["defaults" "size=8G" "mode=755"];
    };

    # system disk
    disk.main = {
      #device = lib.mkDefault "/dev/sda";
      inherit device;
      type = "disk";

      content = {
        type = "gpt";
        partitions = {
          boot = {
            priority = 1;
            name = "boot";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          
          swap = {
            size = "16G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };

          data = {
            size = "100%";
            content = {
              type = "btrfs";
              subvolumes = {
                nix = {
                  type = "filesystem";
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime"];
                };
                persist = {
                  type = "filesystem";
                  mountpoint = "/persist";
                  mountOptions = ["compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };
    };
    
    # data disk 0
    disk.data0 = {
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          vol0 = {
            size = "100%";
            content = {
              type = "btrfs";
              mountpoint = "/mnt/data0";
              mountOptions = ["compress=zstd" "noatime"];
            };
          };
        };
      };
    };
  };
}
