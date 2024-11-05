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
      #inputs.minegrub-theme.nixosModules.default
      inputs.stylix.nixosModules.stylix
  ];
in {
  # universal laptop config
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

  # specific lenovo yoga pro 7 gen 9 config
  laptop-lenovo-yoga = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs flake-confs pkgs pkgs-unstable;
      buildName = "laptop-lenovo-yoga";
    };
    modules = commonModules ++ [
      ./laptop-lenovo-yoga
    ];
  };

  # universal desktop pc config
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
