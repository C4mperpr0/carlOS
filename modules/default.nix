{
  inputs,
  ...
}: {
  modules = [
    ./system
    ./desktop-environment
    ./development
    ./software
    ./presets
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.nix-index-database.nixosModules.nix-index
  ];
}
