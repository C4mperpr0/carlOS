{
  config,
  lib,
  ...
}: let
  cfg = config.nixosModules.carlOS.development.tailscale;
in {
  options = {
    nixosModules.carlOS.development.tailscale = {
      enable = lib.mkEnableOption "enable tailscale for connecting to a tailnet";
    };
  };
  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;

    networking.firewall = {
      trustedInterfaces = [config.services.tailscale.interfaceName];
      allowedUDPPorts = [config.services.tailscale.port];
    };

    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;
  };
}
