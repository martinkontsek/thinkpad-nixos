{
  host,
  lib,
  ...
}: let
  inherit
    (import ../../../hosts/${host}/variables.nix)
    browser
    terminal
    ;
  lua = lib.generators.mkLuaInline;
  toLua = lib.generators.toLua {};

  bind = keys: dsp: {_args = [keys (lua dsp)];};
  exec = keys: cmd: bind keys "hl.dsp.exec_cmd(${toLua cmd})";

  arrowsAndVim = {
    left = "left";
    right = "right";
    up = "up";
    down = "down";
    h = "left";
    l = "right";
    k = "up";
    j = "down";
  };
  perDir = mods: dsp: keys:
    lib.mapAttrsToList
    (key: dir: bind "${mods} + ${key}" "${dsp}({ direction = \"${dir}\" })")
    keys;

  workspaces =
    lib.concatMap (
      i: let
        key = toString (lib.mod i 10);
      in [
        (bind "SUPER + ${key}" "hl.dsp.focus({ workspace = ${toString i} })")
        (bind "SUPER + SHIFT + ${key}" "hl.dsp.window.move({ workspace = ${toString i} })")
      ]
    )
    (lib.range 1 10);
in {
  wayland.windowManager.hyprland.settings.bind =
    [
      (exec "SUPER + Return" terminal)
      (exec "SUPER + K" "list-keybinds")
      (exec "SUPER + SHIFT + Return" "rofi-launcher")
      (exec "SUPER + SHIFT + W" "web-search")
      (exec "SUPER + ALT + W" "wallsetter")
      (exec "SUPER + SHIFT + N" "swaync-client -rs")
      (exec "SUPER + W" browser)
      (exec "SUPER + Y" "kitty -e yazi")
      (exec "SUPER + E" "code")
      (exec "SUPER + R" "emopicker9000")
      (exec "SUPER + S" "screenshootin")
      (exec "SUPER + D" "discord")
      (exec "SUPER + L" "hyprlock")
      (exec "SUPER + C" "hyprpicker -a")
      (exec "SUPER + G" "gedit")
      (exec "SUPER + T" "pypr toggle term")
      (exec "SUPER + M" "pavucontrol")

      (bind "SUPER + Q" "hl.dsp.window.close()")
      (bind "SUPER + P" "hl.dsp.window.pseudo()")
      (bind "SUPER + F" "hl.dsp.window.fullscreen()")
      (bind "SUPER + SHIFT + F" ''hl.dsp.window.float({ action = "toggle" })'')
      (bind "SUPER + SHIFT + C" "hl.dsp.exit()")

      (bind "SUPER + SHIFT + SPACE" ''hl.dsp.window.move({ workspace = "special:special" })'')
      (bind "SUPER + SPACE" "hl.dsp.workspace.toggle_special()")
      (bind "SUPER + CONTROL + right" ''hl.dsp.focus({ workspace = "e+1" })'')
      (bind "SUPER + CONTROL + left" ''hl.dsp.focus({ workspace = "e-1" })'')
      (bind "SUPER + mouse_down" ''hl.dsp.focus({ workspace = "e+1" })'')
      (bind "SUPER + mouse_up" ''hl.dsp.focus({ workspace = "e-1" })'')

      # Two dispatchers on one key -> one Lua function
      {
        _args = [
          "ALT + Tab"
          (lua ''
            function()
              hl.dispatch(hl.dsp.window.cycle_next())
              hl.dispatch(hl.dsp.window.bring_to_top())
            end'')
        ];
      }

      # Media keys. Add { locked = true; repeating = true; } as a third _args entry
      # if you want them to work on the lock screen / repeat while held.
      (exec "XF86AudioRaiseVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
      (exec "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
      (exec "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
      (exec "XF86AudioPlay" "playerctl play-pause")
      (exec "XF86AudioPause" "playerctl play-pause")
      (exec "XF86AudioNext" "playerctl next")
      (exec "XF86AudioPrev" "playerctl previous")
      (exec "XF86MonBrightnessDown" "brightnessctl set 5%-")
      (exec "XF86MonBrightnessUp" "brightnessctl set +5%")

      # Former bindm
      {_args = ["SUPER + mouse:272" (lua "hl.dsp.window.drag()") {mouse = true;}];}
      {_args = ["SUPER + mouse:273" (lua "hl.dsp.window.resize()") {mouse = true;}];}
    ]
    ++ perDir "SUPER + SHIFT" "hl.dsp.window.move" arrowsAndVim
    ++ perDir "SUPER" "hl.dsp.focus" arrowsAndVim
    ++ perDir "SUPER + ALT" "hl.dsp.window.swap" {
      left = "left";
      right = "right";
      up = "up";
      down = "down";
      # keycodes for h / l / k / j
      "code:43" = "left";
      "code:46" = "right";
      "code:45" = "up";
      "code:44" = "down";
    }
    ++ workspaces;
}
