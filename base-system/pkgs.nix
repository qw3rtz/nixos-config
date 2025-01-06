{ pkgs, ... }:
{
  # base packages
  environment.systemPackages = with pkgs; [
    bash
    bottom
    ranger
    openssh
    killall
    lsof
    pciutils
    wget
    vim
    git
    tmux
    tree
    htop
    nvtopPackages.amd
    docker
    docker-compose
    neofetch
    nmap
  ];
}
