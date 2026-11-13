# Monitors moved to hyprland.nix (they were defined in both files before).
{...}: let
  # Size/move are math expressions now; percentages like "70%" are not accepted.
  mw = x: y: "monitor_w*${x} monitor_h*${y}";
  floatC = {
    float = true;
    center = true;
  };
  tagRule = name: class: tag: {
    inherit name;
    match.class = class;
    tag = "+${tag}";
  };
  qsClass = "^(org\\.qt-project\\.qml)$";
  qsDialog = name: title: opacity: {
    inherit name opacity;
    match = {
      class = qsClass;
      title = "^(${title})$";
    };
    float = true;
    center = true;
    border_size = 0;
    rounding = 12;
    size = mw "0.6" "0.6";
  };
in {
  wayland.windowManager.hyprland.settings.window_rule = [
    # Float and center dialog boxes
    ({
        name = "modal-dialogs";
        match.modal = true;
      }
      // floatC)

    {
      name = "WinBoat";
      match.class = "^(winboat)$";
      float = true;
    }
    {
      name = "FreeRDP";
      match.class = "^(FreeRDP)$";
      float = true;
    }
    {
      name = "com.winboat.app";
      match.class = "^(com.winboat.app)$";
      float = true;
    }
    {
      name = "xwayland";
      match.xwayland = true;
      no_blur = true;
    }
    {
      name = "Resolve";
      match = {
        class = "^(\\bresolve\\b)$";
        xwayland = true;
      };
      no_blur = true;
    }
    ({
        name = "foot-floating";
        match.class = "^(foot-floating)$";
        size = mw "0.5" "0.4";
      }
      // floatC)
    ({
        name = "emacs-floating";
        match.initial_title = "^(emacs-floating)$";
        size = mw "0.7" "0.7";
      }
      // floatC)
    ({
        name = "boxbuddy";
        match.title = "^(BoxBuddy)$";
        size = mw "0.7" "0.7";
      }
      // floatC)
    ({
        name = "gearlever";
        match.title = "^(it.mijorus.gearlever)$";
      }
      // floatC)
    ({
        name = "Bazaar";
        match.class = "^(io.github.kolunmi.Bazaar)$";
        size = mw "0.7" "0.7";
      }
      // floatC)
    {
      name = "mpv";
      match.class = "mpv";
      content = "none";
    }

    # ---- Tags ----
    (tagRule "Thunar" "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" "file-manager")
    (tagRule "Terminals" "^(com.mitchellh.ghostty|org.wezfurlong.wezterm|Alacritty|kitty|kitty-dropterm)$" "terminal")
    (tagRule "Brave-browser" "^(Brave-browser(-beta|-dev|-unstable)?)$" "browser")
    (tagRule "Firefox" "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$" "browser")
    (tagRule "Google-chrome" "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" "browser")
    (tagRule "Thorium-browser" "^([Tt]horium-browser|[Cc]achy-browser)$" "browser")
    (tagRule "VideoLan" "^(vlc|mpv)$" "video")
    (tagRule "vscodium" "^(codium|codium-url-handler|VSCodium)$" "projects")
    (tagRule "vscode" "^(VSCode|code-url-handler)$" "projects")
    (tagRule "Discord" "^([Dd]iscord|[Dd]iscordcanary|[Ww]ebCord|[Vv]esktop)$" "im")
    ({
        name = "Ferdium";
        match.class = "^([Ff]erdium)$";
        size = mw "0.6" "0.7";
        tag = "+im";
      }
      // floatC)
    (tagRule "Whatsapp" "^([Ww]hatsapp-for-linux)$" "im")
    (tagRule "Telegram-desktop" "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$" "im")
    (tagRule "teams-for-linux" "^(teams-for-linux)$" "im")
    (tagRule "obs-studio" "^(com.obsproject.Studio)$" "obs")
    (tagRule "gamescope" "^(gamescope)$" "games")
    (tagRule "steam-app" "^(steam_app\\d+)$" "games")
    (tagRule "Steam" "^([Ss]team)$" "gamestore")
    {
      name = "Lutris";
      match.title = "^([Ll]utris)$";
      tag = "+gamestore";
    }
    (tagRule "heroicgameslauncher" "^(com.heroicgameslauncher.hgl)$" "gamestore")
    (tagRule "gnome-disks" "^(gnome-disks|wihotspot(-gui)?)$" "settings")
    (tagRule "rofi" "^([Rr]ofi)$" "settings")
    (tagRule "FileRoller" "^(file-roller|org.gnome.FileRoller)$" "settings")
    (tagRule "NetworkManager" "^(nm-applet|nm-connection-editor|blueman-manager)$" "settings")
    {
      name = "PlusAudio";
      match.class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$";
      center = true;
      tag = "+settings";
    }
    (tagRule "nwg-look" "^(nwg-look|qt5ct|qt6ct|[Yy]ad)$" "settings")
    (tagRule "xdg-desktop-portal-gtk" "(xdg-desktop-portal-gtk)" "settings")
    (tagRule "blueman" "(.blueman-manager-wrapped)" "settings")
    (tagRule "nwg-displays" "(nwg-displays)" "settings")

    # ---- Floating / sizing ----
    {
      name = "Picture-in-Picture";
      match.title = "^(Picture-in-Picture)$";
      float = true;
      move = mw "0.72" "0.07";
      opacity = "0.95 0.75";
      # pin = true;  # uncomment to keep PiP on every workspace
    }
    ({
        name = "ThunarFileMgr";
        match = {
          class = "([Tt]hunar)";
          title = "negative:(.*[Tt]hunar.*)";
        };
      }
      // floatC)
    ({
        name = "Authentication-Required";
        match.title = "^(Authentication Required)$";
      }
      // floatC)
    {
      name = "IdleInhibit-fullscreen";
      match.class = ".*";
      idle_inhibit = "fullscreen";
    }
    {
      name = "Settings-Tag";
      match.tag = "settings*";
      float = true;
      opacity = "0.8 0.7";
      size = mw "0.7" "0.7";
    }
    {
      name = "WayPaper";
      match.class = "^([Ww]aypaper)$";
      float = true;
    }
    {
      name = "Remmina";
      match.class = "^(org.remmina.Remmina)$";
      float = true;
    }

    # ---- Quickshell windows ----
    {
      name = "QS-Wallpapers";
      match = {
        class = qsClass;
        title = "^(Wallpapers)$";
      };
      border_size = 0;
      float = true;
      no_blur = true;
      rounding = 12;
    }
    ({
        name = "QS-Video-Wallpapers";
        match = {
          class = qsClass;
          title = "^(Video Wallpapers)$";
        };
        border_size = 0;
        no_blur = true;
        rounding = 12;
      }
      // floatC)
    ({
        name = "QS-wlogout";
        match = {
          class = qsClass;
          title = "^(qs-wlogout)$";
        };
        border_size = 0;
        opacity = "1.0 1.0";
        rounding = 20;
      }
      // floatC)
    ({
        name = "QS-Panels";
        match = {
          class = qsClass;
          title = "^(Panels)$";
        };
        no_blur = true;
        rounding = 12;
        size = mw "0.6" "0.6";
      }
      // floatC)
    (qsDialog "QS-Hyprland-Keybinds" "Hyprland Keybinds" "0.95 0.95")
    (qsDialog "QS-Niri-Keybinds" "Niri Keybinds" "0.95 0.95")
    (qsDialog "QS-i3-Keybinds" "i3 Keybinds" "0.95 0.95")
    (qsDialog "QS-DWM-Keybinds" "DWM Keybinds" "0.95 0.95")
    (qsDialog "QS-Emacs-Leader" "Emacs Leader Keybinds" "0.95 0.95")
    (qsDialog "QS-Kitty-Config" "Kitty Configuration" "0.95 0.95")
    (qsDialog "QS-Wezterm-Config" "WezTerm Configuration" "0.95 0.95")
    (qsDialog "QS-Yazi-Config" "Yazi Configuration" "0.95 0.85")
    (qsDialog "QS-Cheatsheets" "Cheatsheets Viewer" "0.95 0.95")
    (qsDialog "QS-Documentation-Viewer" "Documentation Viewer" "0.95 0.95")

    # ---- Misc floating ----
    {
      name = "Clapper";
      match.class = "^(com.github.rafostar.Clapper)$";
      float = true;
    }
    ({
        name = "netpeek";
        match.class = "^(io.github.zingytomato.netpeek)$";
      }
      // floatC)
    {
      name = "codium-url-handler";
      match = {
        class = "(codium|codium-url-handler|VSCodium)";
        title = "negative:(.*codium.*|.*VSCodium.*)";
      };
      float = true;
    }
    {
      name = "heroic-float";
      match = {
        class = "^(com.heroicgameslauncher.hgl)$";
        title = "negative:(Heroic Games Launcher)";
      };
      float = true;
    }
    # Must not be named "Steam": rules with the same name merge in Lua.
    {
      name = "Steam-float";
      match = {
        class = "^([Ss]team)$";
        title = "negative:^([Ss]team)$";
      };
      float = true;
    }
    {
      name = "Add-Folder";
      match.initial_title = "(Add Folder to Workspace)";
      float = true;
      size = mw "0.5" "0.4";
    }
    {
      name = "Open-File";
      match.initial_title = "(Open Files)";
      float = true;
      size = mw "0.7" "0.6";
    }
    {
      name = "Wants-to-Save";
      match.initial_title = "(wants to save)";
      float = true;
    }

    # ---- Tag-based opacity / workspaces ----
    {
      name = "Browsers";
      match.tag = "browser*";
      opacity = "1.0 1.0";
      workspace = "2";
    }
    {
      name = "Video";
      match.tag = "video*";
      opacity = "1.0 1.0";
    }
    {
      name = "Projects";
      match.tag = "projects*";
      opacity = "0.9 0.8";
    }
    {
      name = "Instant-Messaging";
      match.tag = "im*";
      opacity = "0.94 0.86";
      workspace = "3";
    }
    {
      name = "File-Managers";
      match.tag = "file-manager*";
      opacity = "0.9 0.8";
    }
    {
      name = "Terminals-opacity";
      match.tag = "terminal*";
      opacity = "0.94 0.7";
    }
    {
      name = "text-editors";
      match.class = "^(gedit|org.gnome.TextEditor|mousepad)$";
      opacity = "0.8 0.7";
    }
    {
      name = "seahorse"; # gnome-keyring gui
      match.class = "^(seahorse)$";
      opacity = "0.9 0.8";
    }
    {
      name = "games-no-blur";
      match.tag = "games*";
      no_blur = true;
    }
    {
      name = "remmina-workspace";
      match.class = "org.remmina.Remmina"; # was misspelled "Reminna"
      workspace = "8";
    }
    {
      name = "obs-workspace";
      match.tag = "obs*";
      workspace = "10";
    }
  ];
}
