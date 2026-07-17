{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    fragment-mono
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Fragment Mono" ];
}
