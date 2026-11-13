{
  host,
  config,
  pkgs,
  lib,
  ...
}: let
  hostVars = import ../../../hosts/${host}/variables.nix;
  inherit (hostVars) keyboardLayout wallpaperImage;
  extraMonitorSettings = hostVars.extraMonitorSettings or "";
  hyprMonitorsV2 = hostVars.hyprMonitorsV2 or [];
  c = config.lib.stylix.colors;
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua {};

  # Legacy hyprlang "monitor=out,mode,pos,scale[,key,val...]" lines -> hl.monitor tables.
  # Prefer moving these into hyprMonitorsV2 in your host variables.
  num = s:
    if builtins.match "-?[0-9]+(\\.[0-9]+)?" s != null
    then builtins.fromJSON s
    else s;
  kvPairs = l:
    if builtins.length l < 2
    then {}
    else {${builtins.elemAt l 0} = num (builtins.elemAt l 1);} // kvPairs (lib.drop 2 l);
  parseMonitorLine = line: let
    f = map lib.trim (lib.splitString ","
      (builtins.head (builtins.match "[[:space:]]*monitor[[:space:]]*=(.*)" line)));
    at = builtins.elemAt f;
  in
    if at 1 == "disable"
    then {
      output = at 0;
      disabled = true;
    }
    else
      {
        output = at 0;
        mode = at 1;
        position = at 2;
        scale = num (at 3);
      }
      // kvPairs (lib.drop 4 f);
  legacyMonitors = map parseMonitorLine (lib.filter
    (l: builtins.match "[[:space:]]*monitor[[:space:]]*=.*" l != null)
    (lib.splitString "\n" extraMonitorSettings));

  v2Monitors =
    map (
      m:
        if (m.enabled or true)
        then {
          inherit (m) output;
          mode = m.mode or "preferred";
          position = m.position or "auto";
          scale = m.scale or 1;
        }
        else {
          inherit (m) output;
          disabled = true;
        }
    )
    hyprMonitorsV2;

  # Former exec-once entries
  startup = [
    "wl-paste --type text --watch cliphist store" # Stores only text data
    "wl-paste --type image --watch cliphist store" # Stores only image data
    "dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "systemctl --user start hyprpolkitagent"
    "killall -q awww;sleep .5 && awww init"
    "killall -q waybar;sleep .5 && waybar"
    "killall -q swaync;sleep .5 && swaync"
    "nm-applet --indicator"
    "pypr"
    "awww-daemon"
    "sleep 1.5 && awww img ${wallpaperImage}"
  ];
in {
  home.packages = with pkgs; [
    awww
    grim
    slurp
    wl-clipboard
    swappy
    ydotool
    hyprpolkitagent
    hyprland-guiutils # needed for banners and ANR messages
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];
  # Place Files Inside Home Directory
  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    ".face.icon".source = ./ufo.jpg;
    ".config/face.jpg".source = ./ufo.jpg;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd = {
      enable = true;
      enableXdgAutostart = true;
      variables = ["--all"];
    };
    xwayland.enable = true;
    configType = "lua";

    settings = {
      monitor =
        [
          {
            output = "";
            mode = "preferred";
            position = "auto";
            scale = "auto";
          }
          {
            output = "Virtual-1";
            mode = "1920x1080@60";
            position = "auto";
            scale = 1;
          }
        ]
        ++ v2Monitors
        ++ legacyMonitors;

      # Runs once at startup (not on every config reload)
      on = [
        {
          _args = [
            "hyprland.start"
            (lua "function()\n${lib.concatMapStrings (cmd: "  hl.exec_cmd(${toLua cmd})\n") startup}end")
          ];
        }
      ];

      # To enable blur on waybar uncomment the line below
      # Thanks to SchotjeChrisman
      # layer_rule = [ { match.namespace = "waybar"; blur = true; } ];

      config = {
        input = {
          kb_layout = keyboardLayout;
          kb_options = "grp:alt_shift_toggle";
          numlock_by_default = true;
          repeat_delay = 300;
          follow_mouse = 1;
          float_switch_override_focus = 0;
          sensitivity = 0;
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            scroll_factor = 0.8;
          };
        };

        gestures = {
          workspace_swipe_distance = 500;
          workspace_swipe_invert = true;
          workspace_swipe_min_speed_to_force = 30;
          workspace_swipe_cancel_ratio = 0.5;
          workspace_swipe_create_new = true;
          workspace_swipe_forever = true;
        };

        general = {
          layout = "dwindle";
          gaps_in = 6;
          gaps_out = 8;
          border_size = 2;
          resize_on_border = true;
          col = {
            active_border = {
              colors = ["rgb(${c.base08})" "rgb(${c.base0C})"];
              angle = 45;
            };
            inactive_border = "rgb(${c.base01})";
          };
        };

        misc = {
          layers_hog_keyboard_focus = true;
          initial_workspace_tracking = 0;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = false;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          enable_swallow = false;
          vrr = 2; # Variable Refresh Rate. Might need to set to 0 for NVIDIA/AQ_DRM_DEVICES
          # Screen flashing to black momentarily or going black when app is fullscreen
          # Try setting vrr to 0

          # Application not responding (ANR) settings
          enable_anr_dialog = true;
          anr_missed_pings = 20;
        };

        dwindle = {
          preserve_split = true;
          force_split = 2;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            ignore_opacity = false;
            new_optimizations = true;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
        };

        ecosystem = {
          no_donation_nag = true;
          no_update_news = false;
        };

        cursor = {
          sync_gsettings_theme = true;
          no_hardware_cursors = 2; # change to 1 if want to disable
          enable_hyprcursor = false;
          warp_on_change_workspace = 2;
          no_warps = true;
        };

        render = {
          direct_scanout = 0;
        };

        master = {
          new_status = "master";
          new_on_top = true;
          mfact = 0.5;
        };
      };
    };
  };
}
