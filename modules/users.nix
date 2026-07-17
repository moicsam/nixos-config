{ config, pkgs, ... }:

{
  users.users.sam = {
    isNormalUser = true;
    description = "sam";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
  };
}
