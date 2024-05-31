{...}: {
  imports = [
    ./basic-configuration.nix
    ./minegrub.nix  
    ./office.nix
    ./social.nix
    ./cli-packages.nix
    ./gaming.nix
    ./programming.nix
    ./ui-utils.nix
    ./desktop-environment.nix
  ];
}
