{host, pkgs, ...}: let
  inherit (import ../../hosts/${host}/variables.nix) printEnable;
in {
  services = {
    printing = {
      enable = printEnable;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        hplipWithPlugin
        canon-cups-ufr2
        canon-capt
      ];
    };
    avahi = {
      enable = printEnable;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = printEnable;
  };
}
