{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
          jeff-hykin.better-nix-syntax
          ms-vscode.cpptools-extension-pack
          #vscodevim.vim # Vim emulation
          mads-hartmann.bash-ide-vscode
          tamasfe.even-better-toml
          zainchen.json
          ms-python.python
          ms-vscode-remote.remote-ssh-edit
        ];
        userSettings = {
          "workbench.colorTheme" = "Visual Studio Dark";
        };
      };
    };
  };
}
