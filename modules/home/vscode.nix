{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          jeff-hykin.better-nix-syntax
          ms-vscode.cpptools
          ms-vscode.cpptools-extension-pack
          #vscodevim.vim # Vim emulation
          mads-hartmann.bash-ide-vscode
          zainchen.json
          ms-python.python
          ms-python.vscode-pylance
          ms-python.debugpy
          ms-vscode-remote.remote-ssh-edit
          ms-vscode-remote.remote-ssh
          ms-vscode.remote-explorer
          ms-azuretools.vscode-containers
          eamodio.gitlens
          adpyke.codesnap
          redhat.ansible
          moshfeu.compare-folders
          golang.go
          redhat.vscode-yaml
        ];
        userSettings = {
          "workbench.colorTheme" = "Visual Studio Dark";
        };
      };
    };
  };
}
