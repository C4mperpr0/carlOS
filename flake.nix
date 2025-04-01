{
  description = "The official Carl Operation System! Yes, the one Carl is using!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager?ref=release-24.11";
    ags.url = "github:aylur/ags"; # Aylur's GTK Shell
    astal.url = "github:aylur/astal"; # needed for ags
    stylix.url = "github:danth/stylix/release-24.11";
    spicetify-nix.url = "github:the-argus/spicetify-nix"; # spicetify-cli via a flake
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dromedar-nvim = {
      url = "gitlab:dr0med4r/nvim-nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "nixpkgs";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    #minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = inputs @ {self, ...}: let
    flake-confs = import ./flake-confs.nix;
    #lib = super.lib // { carlOS = import ./lib; }

    #lib =
    #  inputs.nixpkgs.lib.extend
    #  (self: super: {
    #    carlOS = import ./lib;
    #  });
  in {
    #nixosConfigurations = import ./hosts {
    #  inherit inputs flake-confs self carlOS-lib;
    #};
    modules = (import ./modules {inherit inputs flake-confs;}).modules;
  };
}
