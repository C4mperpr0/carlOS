{
  inputs,
  flake-confs,
  ...
}: let
  system = flake-confs.system;
  lib = inputs.nixpkgs.lib;
  commonModules = [
    ../modules/system
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.nix-index-database.nixosModules.nix-index
  ];
  modules =
    (import ../modules {inherit inputs flake-confs;}).modules;
in {
  # generic-desktop config
  generic-desktop = {
    #lib.nixosSystem {
    buildName = "generic-desktop";
    modules = modules;
  };
}
