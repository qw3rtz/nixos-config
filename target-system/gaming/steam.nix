{ pkgs, ...}:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # proton steam issue: avoid "too many open files" error on some games
  security.pam.loginLimits = [
  {
    domain = "*";
    type = "-";
    item = "nofile";
    value = "13107200";
  }
  {
    domain = "*";
    type = "-";
    item = "memlock";
    value = "13107200";
  }];

  #programs.gamescope = {
  #  enable = true;
  #  capSysNice = true;
  #  args = [
  #    "--steam"
  #    "--expose-wayland"
  #    "--rt"
  #    "-W 2560"
  #    "-H 1440"
  #    "--force-grab-cursor"
  #    "--grab"
  #    "--fullscreen"
  #  ];
  #};
}
