{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "buttonless";
      };
      font = {
        size = 12.0;
      };
    };
  };
}
