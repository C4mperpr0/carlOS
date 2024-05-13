{
  pkgs,
  pkgs-unstable,
  ...
}: {
  users.users.carl.packages = with pkgs; [
    cowsay
    nix-search-cli
    asciiquarium
    hyfetch
    fastfetch
    btop
    zoxide
    spotify-tui
    gitui
    lolcat
    lf # cli file manager
  ];
  fonts.packages = with pkgs; [nerdfonts];
  environment.systemPackages = with pkgs; [
    git
    pkgs-unstable.nh
    nano
  ];
}
