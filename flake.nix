{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=release-23.11";
  };

  outputs = inputs @ {self, ...}: {
    nixosConfigurations = import ./hosts {
      inherit inputs;
    };
  };
}
