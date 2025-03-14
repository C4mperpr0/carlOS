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
in {
  # universal laptop config
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit self inputs flake-confs pkgs pkgs-unstable;
      buildName = "laptop";
    };
    modules =
      commonModules
      ++ [
        ./laptop
      ];
  };

  # specific lenovo yoga pro 7 gen 9 config
  generic-desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit self inputs flake-confs pkgs pkgs-unstable;
      buildName = "generic-desktop";
    };
    modules =
      commonModules
      ++ [
        ./generic_desktop
      ];
  };

  # specific lenovo yoga pro 7 gen 9 config
  laptop-lenovo-yoga = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit self inputs flake-confs pkgs pkgs-unstable;
      buildName = "laptop-lenovo-yoga";
    };
    modules =
      commonModules
      ++ [
        ./laptop-lenovo-yoga
      ];
  };

  # universal desktop pc config
  pc = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit self inputs flake-confs pkgs pkgs-unstable;
      buildName = "pc";
    };
    modules =
      commonModules
      ++ [
        ./pc
      ];
  };
}
