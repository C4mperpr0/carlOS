{inputs, ...}: {
  modules = [
    ./system
    ./desktop-environment
    ./development
    ./software
    ./presets
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.serpantinum.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
  ];
}
