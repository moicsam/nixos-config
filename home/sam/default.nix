{ config, pkgs, lib, inputs, ... }:

{
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  imports = [
    ./apps/alacritty.nix
    ./apps/zsh.nix
    ./apps/git.nix
    inputs.nixvim.homeModules.nixvim
    inputs.catppuccin.homeModules.catppuccin
  ];

  home.packages = with pkgs; [
    keepassxc
    tidal-hifi
    zed-editor
    logseq
    signal-desktop
    inputs.vibe.packages.${system}.default
  ];

  services.syncthing.enable = true;

  home.stateVersion = "25.11";
}
