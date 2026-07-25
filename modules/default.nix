{ pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./users.nix
    ./networking.nix
    ./desktop/default.nix
    ./services/bluetooth.nix
    ./services/docker.nix
    ./services/pipewire.nix
    ./services/printing.nix
    # ./services/desktop_environment.nix
    ./services/ssh.nix
    ./services/virtmanager.nix
    ./services/nix-ld.nix
  ];


  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-vga none"
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
    ];
  };

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure console keymap
  console.keyMap = "fr-bepo";

  system.stateVersion = "25.11";
}
