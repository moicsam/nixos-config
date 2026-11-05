{ config, inputs, ... }:

{
  flake.nixosConfigurations.ficus = inputs.nixpkgs.lib.nixosSystem {
    modules = [ config.flake.modules.nixos.host-ficus ];
  };

  flake.modules.nixos.host-ficus = { lib, pkgs, ... }: {
    imports = with config.flake.modules.nixos; [
      base
      ssh
      tailscale
      radicale
      packages
    ] ++ [ ./_hardware.nix ];

    networking.hostName = "ficus";
    boot.loader.systemd-boot.enable = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;


    system.stateVersion = lib.mkDefault "26.05";

    users.users.sam.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHjHguoSb77hDl7ux/KH+nOMl1N6wd+Cah09GpeIy8C0 sam@drosera"
    ];


    home-manager.users.sam.imports = with config.flake.modules.homeManager; [
      ficus
      git
      neovim
    ];
  };

  flake.modules.homeManager.ficus = { lib, ... }: {
    home.stateVersion = lib.mkDefault "26.05";
  };
}
