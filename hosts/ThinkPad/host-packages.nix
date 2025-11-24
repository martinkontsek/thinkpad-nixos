{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mission-center
    onlyoffice-desktopeditors
    enpass
    restic
    rclone
    dropbox
    remmina
    teamviewer
    rustdesk
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
  ];
}
