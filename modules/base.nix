{ inputs, ... }:

{
  flake.modules.nixos.base = {lib, ...}: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    console.keyMap = lib.mkDefault "fr-bepo";

    users.users.sam = {
      isNormalUser = true;
      password = "admin";
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      extraSpecialArgs = { inherit inputs; };
    };
  };
}
