{
  inputs,
  flake-confs,
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
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs flake-confs pkgs pkgs-unstable;};
    modules = [
      ./laptop
      inputs.home-manager.nixosModules.home-manager
      ../modules/system
    ];
  };
  pc = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs flake-confs pkgs pkgs-unstable;};
    modules = [
      ./pc
      inputs.home-manager.nixosModules.home-manager
      ../modules/system
    ];
  };
}
