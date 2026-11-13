{...}: let
  dpms = state: "hyprctl dispatch 'hl.dsp.dpms({ action = \"${state}\" })'";
in {
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = dpms "on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = dpms "off";
            on-resume = dpms "on";
          }
        ];
      };
    };
  };
}
