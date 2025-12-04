{pkgs, pkgs-master, ...}: {
  environment.systemPackages = [
    pkgs.mission-center
    pkgs.onlyoffice-desktopeditors
    pkgs.enpass
    pkgs.restic
    pkgs.rclone
    pkgs.dropbox
    pkgs.remmina
    pkgs.teamviewer
    pkgs.rustdesk
    pkgs.ansible
    pkgs.vagrant
    pkgs.mc
    pkgs.postman
    pkgs.nmap
    pkgs.gnome-disk-utility
    pkgs.nwg-displays
    pkgs.putty
    pkgs.kubectl
    pkgs._7zz
    pkgs.inetutils
    pkgs.opentofu
    pkgs-master.winbox4 # Mikrotik config app
  ];
}
