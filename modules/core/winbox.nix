{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  programs.winbox = {
    enable = true;
    package = pkgs.winbox4;
    openFirewall = true; 
  };
}
