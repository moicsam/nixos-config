{ pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./users.nix
    ./networking.nix
    ./services/bluetooth.nix
    ./services/docker.nix
    ./services/pipewire.nix
    ./services/printing.nix
    ./services/desktop_environment.nix
    ./services/ssh.nix
    ./services/virtmanager.nix
    ./services/fonts.nix
    ./services/nix-ld.nix
  ];

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";
}
