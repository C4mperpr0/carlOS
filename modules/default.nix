{
  inputs,
  flake-confs,
  ...
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
in {
  modules = [
    ./system
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.nix-index-database.nixosModules.nix-index
  ];
}
