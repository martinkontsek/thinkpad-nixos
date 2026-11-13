{lib, ...}: {
  wayland.windowManager.hyprland.settings.env =
    lib.mapAttrsToList (name: value: {_args = [name value];}) {
      NIXOS_OZONE_WL = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
      GDK_BACKEND = "wayland,x11";
      CLUTTER_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      SDL_VIDEODRIVER = "x11";
      MOZ_ENABLE_WAYLAND = "1";
      # Disabled by default as it can break configurations with more than two GPUs.
      # Mostly needed for hybrid laptops.
      # AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
      GDK_SCALE = "1";
      QT_SCALE_FACTOR = "1";
      EDITOR = "nvim";
      # Setting terminal to kitty so running kitty from rofi won't launch in xterm.
      # ToDo: Pull default terminal from host config
      TERMINAL = "kitty";
      XDG_TERMINAL_EMULATOR = "kitty";
    };
}
