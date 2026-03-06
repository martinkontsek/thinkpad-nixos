{host, pkgs, ...}: let
  inherit (import ../../hosts/${host}/variables.nix) printEnable;
in {
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        hplipWithPlugin
        canon-cups-ufr2
        canon-capt
        gutenprint
        gutenprintBin
      ];
      browsing = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish.enable = true;
      publish.workstation = true;
      publish.addresses = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
  };
}
