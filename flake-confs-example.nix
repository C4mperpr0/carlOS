{
  user = {
    name = "nixos";
    description = "Default NixOS User";
  };
  hostname = "nixos";
  buildname = "carlOS";
  system = "x86_64-linux";
  desktop-environment = {
    hyprland = {
      hypridle = {
        display-dimm-after = 240;
        display-off-after = 270;
        lock-after = 300;
        sleep-after = 315;
      };
    };
  };
}
