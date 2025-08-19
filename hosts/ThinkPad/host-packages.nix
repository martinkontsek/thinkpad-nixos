{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mission-center
    onlyoffice-desktopeditors
    teams-for-linux
    enpass
    restic
    rclone
    dropbox
    zerotierone
    openfortivpn
    openvpn
    wireguard-tools
    remmina
    teamviewer
    rustdesk
    winbox4
    ansible
    virtualbox
    vagrant
    mc
    postman
  ];
}
