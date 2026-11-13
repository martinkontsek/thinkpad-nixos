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
  # name "moving"
  # credit https://github.com/mylinuxforwork/dotfiles
  wayland.windowManager.hyprland.settings = {
    config.animations.enabled = true;
    curve = [
      (curve "overshot" 0.05 0.9 0.1 1.05)
      (curve "smoothOut" 0.5 0 0.99 0.99)
      (curve "smoothIn" 0.5 (-0.5) 0.68 1.5)
    ];
    animation = [
      (anim "windows" 5 "overshot" {style = "slide";})
      (anim "windowsOut" 3 "smoothOut" {})
      (anim "windowsIn" 3 "smoothOut" {})
      (anim "windowsMove" 4 "smoothIn" {style = "slide";})
      (anim "border" 5 "default" {})
      (anim "fade" 5 "smoothIn" {})
      (anim "fadeDim" 5 "smoothIn" {})
      (anim "workspaces" 6 "default" {})
    ];
  };
}
