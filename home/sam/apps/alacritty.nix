{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.95;
      font = {
        size = 12.0;
      };
    };
  };

  catppuccin = {
    alacritty.enable = true;
    flavor = "mocha";
  };
}
