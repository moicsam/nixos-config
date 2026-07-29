{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    tidal-hifi
    logseq
    signal-desktop
    inputs.vibe.packages.${system}.default
  ];
}
