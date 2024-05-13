{
  pkgs,
  ...
}: {
  users.users.carl.packages = with pkgs; [
    steam
    discord
    supertuxkart
    nxengine-evo
  ];
  fonts.packages = with pkgs; [nerdfonts];
  environment.systemPackages = with pkgs; [
    git
    pkgs-unstable.nh
    nano
  ];
}
