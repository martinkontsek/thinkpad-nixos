{
  pkgs,
  config,
  ...
}: {
  services.lldpd.enable = true;
  services.lldpd.extraArgs = [ "-c" ];
}
