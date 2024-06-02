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
  commonModules = [
      inputs.home-manager.nixosModules.home-manager
      ../modules/system
      inputs.minegrub-theme.nixosModules.default
  ];
in {
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs flake-confs pkgs pkgs-unstable;
      buildName = "laptop";
    };
    modules = commonModules ++ [
      ./laptop
    ];
  };
  pc = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs flake-confs pkgs pkgs-unstable;
      buildName = "pc";
    };
    modules = commonModules ++ [
      ./pc
    ];
  };
}
