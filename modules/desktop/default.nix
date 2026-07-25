{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./greetd.nix
    ./niri.nix
  ];
}
