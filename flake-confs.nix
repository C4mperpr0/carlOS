{
  outputs = let
    flake-confs = {
      user = {
        name = "carl";
        description = "Carl";
      };
      hostname = "nixos";
      system = "x86_64-linux";
    };
  in {
    inherit flake-confs;
  };
}

