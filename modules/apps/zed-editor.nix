{ ... }:

{
  flake.modules.homeManager.zed-editor = { pkgs, ... }: {
    programs.zed-editor = {
      enable = true;
      extraPackages = [ pkgs.nixd ];

      userSettings = {
        hour_format = "hour24";
      };
    };

    catppuccin.zed = {
      enable = true;
      icons = {
        enable = true;
        flavor = "mocha";
      };
      italics = true;
    };
  };
}
