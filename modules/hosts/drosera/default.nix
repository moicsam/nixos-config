{ inputs, config, ... }:

{
  flake.nixosConfigurations.drosera = inputs.nixpkgs.lib.nixosSystem {
    modules = [ config.flake.modules.nixos.host-drosera ];
  };

  flake.modules.nixos.host-drosera = { lib, pkgs, ... }: {
    imports = with config.flake.modules.nixos; [
      base
      desktop
      zsh
      docker
      ssh
      printing
      udisks
      virtmanager
      nix-ld
      networking
      packages
    ] ++ [ ./_hardware.nix ];

    networking.hostName = "drosera";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    virtualisation.vmVariant = {
      virtualisation = {
        memorySize = 4096;
        cores = 4;
        qemu.options = [
          "-vga none"
          "-device virtio-vga-gl"
          "-display gtk,gl=on"
        ];
      };
    };

    system.stateVersion = lib.mkDefault "25.11";

    home-manager.users.sam.imports = with config.flake.modules.homeManager; [
      desktop
      drosera
      zsh
      git
      direnv
      zed-editor
      udisks
      keepassxc
    ];
  };

  flake.modules.homeManager.drosera = { lib, ... }: {
    home.stateVersion = lib.mkDefault "25.11";
  };
}
