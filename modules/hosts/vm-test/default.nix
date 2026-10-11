{ config, ... }:

{
  flake.modules.nixosConfigurations.vm-test = {
    imports = with config.flake.modules.nixos; [
      base
      ssh
      docker
    ] ++ [ ./_hardware.nix ];

    networking.hostName = "vm-test";

    system.stateVersion = "25.11";

    home-manager.users.sam.imports = with config.flake.modules.homeManager; [
      base
      git
    ];
  };

  flake.modules.homeManager.vm-test = {
      home.stateVersion = "25.11";
  };
}
