{host, ...}: let
  inherit (import ../../hosts/${host}/variables.nix) waybarChoice;
in {
  imports = [
    ./bash.nix
    ./bashrc-personal.nix
    ./bat.nix
    ./bottom.nix
    ./btop.nix
    ./cava.nix
    ./chrome.nix
    ./emoji.nix
    ./eza.nix
    ./fastfetch
    ./fzf.nix
    ./gh.nix
    ./ghostty.nix
    ./git.nix
    ./gtk.nix
    ./htop.nix
    ./hyprland
    ./kitty.nix
    ./lazygit.nix
    ./nvf.nix
    ./rofi
    ./qt.nix
    ./scripts
    ./starship.nix
    ./stylix.nix
    ./swappy.nix
    ./swaync.nix
    ./tmux.nix
    ./virtmanager.nix
    ./vscode.nix
    waybarChoice
    ./wezterm.nix
    ./wlogout
    ./xdg.nix
    ./yazi
    ./zoxide.nix
    ./zsh
  ];
}
