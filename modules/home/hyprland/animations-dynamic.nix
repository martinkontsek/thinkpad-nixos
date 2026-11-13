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
  # name "Dynamic"
  # credit https://github.com/mylinuxforwork/dotfiles
  wayland.windowManager.hyprland.settings = {
    config.animations.enabled = true;
    curve = [
      (curve "wind" 0.05 0.9 0.1 1.05)
      (curve "winIn" 0.1 1.1 0.1 1.1)
      (curve "winOut" 0.3 (-0.3) 0 1)
      (curve "liner" 1 1 1 1)
    ];
    animation = [
      (anim "windows" 6 "wind" {style = "slide";})
      (anim "windowsIn" 6 "winIn" {style = "slide";})
      (anim "windowsOut" 5 "winOut" {style = "slide";})
      (anim "windowsMove" 5 "wind" {style = "slide";})
      (anim "border" 1 "liner" {})
      (anim "borderangle" 30 "liner" {style = "loop";})
      (anim "fade" 10 "default" {})
      (anim "workspaces" 5 "wind" {})
    ];
  };
}
