{...}: {
  wayland.windowManager.hyprland.settings = {
    config.animations.enabled = true;
    animation =
      map (leaf: {
        inherit leaf;
        enabled = false;
      }) [
        "windows"
        "windowsIn"
        "windowsOut"
        "windowsMove"
        "border"
        "fade"
        "workspaces"
      ];
  };
}
