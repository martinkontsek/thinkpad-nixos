{...}: let
  curve = name: x1: y1: x2: y2: {
    _args = [
      name
      {
        type = "bezier";
        points = [[x1 y1] [x2 y2]];
      }
    ];
  };
  anim = leaf: speed: bezier: extra:
    {
      inherit leaf speed bezier;
      enabled = true;
    }
    // extra;
in {
  # Name: END-4
  # Credit: END-4 project https://github.com/end-4/dots-hyprland
  wayland.windowManager.hyprland.settings = {
    config.animations.enabled = true;
    curve = [
      (curve "linear" 0 0 1 1)
      (curve "md3_standard" 0.2 0 0 1)
      (curve "md3_decel" 0.05 0.7 0.1 1)
      (curve "md3_accel" 0.3 0 0.8 0.15)
      (curve "overshot" 0.05 0.9 0.1 1.1)
      (curve "crazyshot" 0.1 1.5 0.76 0.92)
      (curve "hyprnostretch" 0.05 0.9 0.1 1.0)
      (curve "menu_decel" 0.1 1 0 1)
      (curve "menu_accel" 0.38 0.04 1 0.07)
      (curve "easeInOutCirc" 0.85 0 0.15 1)
      (curve "easeOutCirc" 0 0.55 0.45 1)
      (curve "easeOutExpo" 0.16 1 0.3 1)
      (curve "softAcDecel" 0.26 0.26 0.15 1)
      (curve "md2" 0.4 0 0.2 1) # use with .2s duration
    ];
    animation = [
      (anim "windows" 3 "md3_decel" {style = "popin 60%";})
      (anim "windowsIn" 3 "md3_decel" {style = "popin 60%";})
      (anim "windowsOut" 3 "md3_accel" {style = "popin 60%";})
      (anim "border" 10 "default" {})
      (anim "fade" 3 "md3_decel" {})
      (anim "layersIn" 3 "menu_decel" {style = "slide";})
      (anim "layersOut" 1.6 "menu_accel" {})
      (anim "fadeLayersIn" 2 "menu_decel" {})
      (anim "fadeLayersOut" 4.5 "menu_accel" {})
      (anim "workspaces" 7 "menu_decel" {style = "slide";})
    ];
  };
}
