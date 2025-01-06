{ pkgs, lib, inputs, ... }:
{
  networking.hostName = "tux-tower"; 
  networking.networkmanager.enable = false; # not working with wireless enabled = true
  networking.wireless.enable = true;
  networking.wireless.networks = {
    qwerty = {
      hidden = true;
      pskRaw="862c896db033a5e767df4196075293f193b85a47e76b8ab59fec721250c05904";
    };
  };
  # TODO: setup nat and routing 
  networking.useDHCP = false;
  networking.interfaces.wlp12s0.useDHCP = true;
  networking.firewall.enable = false;
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain"; 
}

