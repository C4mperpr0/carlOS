{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.nixosModules.carlOS.plymouth;
in {
  options = {
    nixosModules.carlOS.plymouth = {
      enable = lib.mkEnableOption "enable plymouth splash screen";
    };
  };
  config = lib.mkIf cfg.enable {
    stylix.targets.plymouth.enable = false; # TODO: for some reason nix says that the theme is set twice, by this and by stylix, even though stylix is disable in nix-inspect. The temporary longterm fix is this mkForce.
    boot.plymouth = {
      enable = true;
      themePackages = with pkgs; [
        plymouth-blahaj-theme
      ];
      theme = "blahaj";
    };
  };
}
