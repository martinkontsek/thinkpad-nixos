{pkgs,pkgs-custom, ...}: {
  # Only enable either docker or podman -- Not both
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
    podman.enable = false;
    virtualbox.host.enable = true;
    virtualbox.host.package = pkgs-custom.virtualbox;
  };
  programs = {
    virt-manager.enable = true;
  };
  environment.systemPackages = with pkgs; [
    virt-viewer # View Virtual Machines
  ];
}
