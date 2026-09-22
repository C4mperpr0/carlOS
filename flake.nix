{
  description = "The official Carl Operation System! Yes, the one Carl is using and Dromedar is fixing!";

  inputs = {
    ### nixpkgs and home-manager
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### misc
    # needed for stylix
    base16 = {
      url = "github:SenchoPens/base16.nix";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.base16.follows = "base16";
    };
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-dromedar = {
      # Höcker
      url = "gitlab:dr0med4r/nvim-nixos";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    serpantinum = {
      url = "github:ilyamiro/serpantinum";
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
