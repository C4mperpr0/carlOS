{inputs}: let
  system = "x86_64-linux";
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
    specialArgs = {inherit inputs pkgs pkgs-unstable;};
    modules = [
      ./laptop
      inputs.home-manager.nixosModules.home-manager
      ../modules/system
    ];
  };
  pc = lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs pkgs pkgs-unstable;};
    modules = [
      ./pc
      inputs.home-manager.nixosModules.home-manager
      ../modules/system
    ];
  };
}
