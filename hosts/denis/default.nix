{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/default.nix
  ];

  users.defaultUserShell = pkgs.zsh; 
  environment.shells = [ pkgs.zsh ];

  # Configuration spécifique machine
  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "denis";
}
