{
  description = "The official Carl Operation System! Yes, the one Carl is using!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=release-24.05";
    ags.url = "github:Aylur/ags"; # Aylur's GTK Shell 
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:the-argus/spicetify-nix"; # spicetify-cli via a flake
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = inputs @ {self, ...}: let
    flake-confs = import ./flake-confs.nix;
  in {
    nixosConfigurations = import ./hosts {
      inherit inputs flake-confs;
    };
  };
}
