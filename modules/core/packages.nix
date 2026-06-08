{pkgs, pkgs-master, ...}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    firefox.enable = true; # Firefox is not installed by default
    dconf.enable = true;
    seahorse.enable = true;
    hyprland.enable = true; #create desktop file and depedencies if you switch to GUI login MGR
    hyprlock.enable = true; #resolve pam issue https://gitlab.com/Zaney/zaneyos/-/issues/164
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  services.teamviewer.enable = true;  # TeamViewer remote desktop software

  environment.systemPackages = with pkgs; [
    appimage-run # Needed For AppImage Support
    bottom # btop like util
    brave # Brave Browser
    brightnessctl # For Screen Brightness Control
    cmatrix # Matrix Movie Effect In Terminal
    cowsay # Great Fun Terminal Program
    duf # Utility For Viewing Disk Usage In Terminal
    dysk # disk usage util
    eza # Beautiful ls Replacement
    ffmpeg # Terminal Video / Audio Editing
    file-roller # Archive Manager
    gdu # graphical disk usage
    gedit # Simple Graphical Text Editor
    gimp # Great Photo Editor
    mesa-demos # Needed for inxi -G GPU info
    gping #graphical ping
    tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    hyprpicker # Color Picker
    loupe # For Image Viewing
    inxi # CLI System Information Tool
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    lm_sensors # Used For Getting Hardware Temps
    lolcat # Add Colors To Your Terminal Command Output
    lshw # Detailed Hardware Information
    mpv # Incredible Video Player
    ncdu # Disk Usage Analyzer With Ncurses Interface
    nitch # small fetch util
    nixfmt # Nix Formatter
    onefetch #shows current build info and stats
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    rhythmbox
    ripgrep # Improved Grep
    socat # Needed For Screenshots
    sox # audio support for FFMPEG
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    waypaper # backup wallpaper GUI
    wget # Tool For Fetching Files With Links
    ytmdl # Tool For Downloading Audio From YouTube
    wireshark # Packet capture
    evince # PDF viewer from GNOME
    #bambu-studio # BambuLab Slicer
    zerotierone # ZeroTier VPN
    openfortivpn # Forti VPN
    openvpn # OpenVPN
    wireguard-tools # Wireguard VPN
    gnome-calculator # Calculator
    qbittorrent # BT client
    progress # show progress of coreutils programs
    sshuttle # ssh tunnel
    devenv
    yt-dlp # video downloader
    powertop # Power usage utility
    libreoffice-fresh # Office Suite
    talosctl # Talos Linux control tool
    android-tools
    prusa-slicer
    orca-slicer
    ipmitool
    smartmontools
    pigz # Parallel gzip
    speedtest-cli # Speedtest.net CLI
    arp-scan # Network Scanner
    angryipscanner # Network Scanner
    chromedriver # For Selenium WebDriver
    geckodriver # For Selenium WebDriver
    # rustdesk # Remote Desktop Software
    heimdall # For Samsung Device Management
    winboat # Win Apps On Linux
    openssl # For Generating SSL Certificates
    (python314.withPackages (python-pkgs: with python-pkgs; [
      requests
      flask
      fastapi
      fastapi-cli
      scapy
      paramiko
      netmiko
      tkinter
      fpdf2
      pypdf
      # pipx
      ansible
      kivy # For Kivy GUI Framework
      kivy-garden # For Kivy GUI Builder
      qrcode # For QR Code Generation
      selenium # For Web Automation
      pyotp # For 2FA Code Generation
      playwright # For Web Automation
      pynetbox # For NetBox API Interaction
    ]))
  ];
  services.udev.packages = [ pkgs.heimdall ];
}
