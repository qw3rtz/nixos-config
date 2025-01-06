{pkgs, lib, inputs, ...}:
{
  imports = [
    ./env.nix
  ];

  users.users.j0n5s = {
    isNormalUser = true;
    initialHashedPassword = "$6$R8i7G6mGAX8TscYr$ptP6g0o0gElDOfML8nApCZuhfA.oaHyohVC3PN6XRCvbaWarpqoHlmbFFc1sk/c363W7CjztUJgGgDerF3OVL.";
    extraGroups = [ "wheel" "docker" "libvirtd" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # avoid password request if using sudo for specific user
  security.sudo.extraRules = [
    {
      users = [ "j0n5s" ];
      commands = [
        {
          command = "ALL";
          options = [ "SETENV" "NOPASSWD" ];
        }
      ];
    }
  ];
  
  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "j0n5s" = import ./home-manager.nix;
    };
  };
}
