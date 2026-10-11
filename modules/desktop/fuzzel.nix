{ ... }:

{
  flake.modules.homeManager.fuzzel = {
    programs.fuzzel = {
      enable = true;
    };

    catppuccin.fuzzel.enable = true;
  };
}
