{
  description = "The official Carl Operation System! Yes, the one Carl is using!";

  inputs = {
    ### nixpkgs and home-manager
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      #url = "github:nix-community/home-manager?ref=release-25.05";
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### misc
    # Aylur's GTK Shell
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # needed for ags
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dromedar-nvim = {
      url = "gitlab:dr0med4r/nvim-nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    #minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = inputs @ {...}: let
    carlOS-lib = import ./lib;
  in {
    inherit carlOS-lib;
    modules = flake-confs: (import ./modules {inherit inputs flake-confs;}).modules;
  };
}
