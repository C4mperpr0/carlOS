{pkgs, pkgs-unstable, ...}: {
  users.users.carl.packages = with pkgs; [
    discord
    whatsapp-for-linux
    signal-desktop
    spotify
    sptlrx # spotify lyrics in cli
  ];
}
