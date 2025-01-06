{ ... }:
{
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.Policy.AutoEnable = "true";
    settings.General = {
        Enable = "Source,Sink,Media,Socket";
        #Name = "Hello";
        ControllerMode = "dual";
        FastConnectable = "true";
        #Experimental = "true";
        #KernelExperimental = "true";
    };
  };
}
