{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  services.zerotierone = {
    enable = true;
    package = pkgs.zerotierone;
  };
}
