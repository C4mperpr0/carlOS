{
  inputs,
  flake-confs,
  self,
}: let
  system = flake-confs.system;
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
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
