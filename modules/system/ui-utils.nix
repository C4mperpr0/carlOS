{
  pkgs,
  ...
}: {
  users.users.carl.packages = with pkgs; [
    systmdgenie
    gparted
    qdirstat
  ];
}
