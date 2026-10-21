{ ... }:

{
  flake.modules.homeManager.packages = { inputs, pkgs, ... }: {
    home.packages = with pkgs; [
      tidal-hifi
      logseq
      signal-desktop
      inputs.vibe.packages.${system}.default
      ghidra
      brave
      bruno
      plantuml
      libreoffice-qt
      zettlr
      burpsuite
      wireshark
    ];
  };
}
