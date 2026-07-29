{ config, pkgs, ... }:
{
  imports = [
    ./package.nix
    ./niri.nix
    ./lock.nix
    ./wallpaper.nix
    ./waybar/waybar.nix
    ./swaync.nix
  ];
}
