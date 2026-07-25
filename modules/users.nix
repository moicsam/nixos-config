{ config, pkgs, ... }:

{
  users.users.sam = {
    isNormalUser = true;
    password = "admin";
    description = "sam";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
  };
}
