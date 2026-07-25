{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaybg
    grim
    slurp
    wl-clipboard
    cliphist
    pavucontrol
    networkmanagerapplet
    brightnessctl
    playerctl
  ];
}
