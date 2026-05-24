{pkgs, pkgs-master, pkgs-custom, ...}: {
  environment.systemPackages = with pkgs; [
    mission-center
    onlyoffice-desktopeditors
    pkgs-master.enpass
    restic
    rclone
    dropbox
    remmina
    ansible
    vagrant
    mc
    postman
    nmap
    gnome-disk-utility
    nwg-displays
    putty
    kubectl
    _7zz
    inetutils
    opentofu
    pkgs-master.winbox4 # Mikrotik config app
  ];
}
