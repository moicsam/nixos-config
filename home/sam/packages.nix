{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    tidal-hifi
    logseq
    signal-desktop
    inputs.vibe.packages.${system}.default
    ghidra
    xwayland-satellite
  ];
}
