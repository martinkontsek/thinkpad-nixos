{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Martin Kontsek";
  gitEmail = "martinkontsek@gmail.com";

  # Hyprland Settings
  # ex "monitor=HDMI-A-1, 1920x1080@60,auto,1"
  #
  extraMonitorSettings = "
    monitor = Virtual-1, 1920x1080@60,auto,1
    ";

  # Waybar Settings
  clock24h = true;

  # Program Options
  browser = "firefox"; # Set Default Browser (firefox/brave/google-chrome)
  terminal = "ghostty"; # Set Default System Terminal
  keyboardLayout = "us,sk";
  consoleKeyMap = "us";

  # For Nvidia Prime support
  #intelID = "PCI:1:0:0";
  #nvidiaID = "PCI:0:2:0";

  # Enable NFS
  enableNFS = false;

  # Enable Printing Support
  printEnable = true;

  # Set Stylix Image
  stylixImage = ../../wallpapers/25.05.jpg;
  wallpaperImage = ../../wallpapers/25.11.jpg;

  # Set Waybar
  # Includes alternates such as:
  # Just uncomment the one you want and comment out the others

  #waybarChoice = ../../modules/home/waybar/Jerry-waybar.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-simple.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-curved.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-nekodyke.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-ddubs.nix;
  #waybarChoice = ../../modules/home/waybar/waybar-ddubs-2.nix;
  waybarChoice = ../../modules/home/waybar/waybar-ddubs-3.nix;

  # Set Animation style
  # Available options are:
  # animations-def.nix  (standard)
  # animations-end4.nix (end-4 project)
  # animations-dynamic.nix (ml4w project)
  # animations-moving.nix (ml4w project)
  # Just change the name after the - and rebuild
  animChoice = ../../modules/home/hyprland/animations-end4.nix;

  # Enable Thunar GUI File Manager
  thunarEnable = true;
}
