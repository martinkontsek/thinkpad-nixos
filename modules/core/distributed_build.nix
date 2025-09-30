{pkgs, ...}: {
  nix = {
    distributedBuilds = true;
    buildMachines = [
      {
        hostName = "nixos-builder";
        systems = ["x86_64-linux"];
        maxJobs = 4;
        speedFactor = 2;
        supportedFeatures = ["nixos-test" "benchmark" "big-parallel" "kvm"];
      }
    ];
    settings = {
      builders-use-substitutes = true;
    };
  };
  programs.ssh.extraConfig = ''
    Host nixos-builder
      HostName 158.193.154.239
      Port 22
      User root
      IdentitiesOnly yes
      IdentityFile /root/.ssh/id_builder
  '';
}
