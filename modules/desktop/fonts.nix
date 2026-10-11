{ ... }:

{
  flake.modules.nixos.fonts = { pkgs, ... }: {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        papirus-icon-theme
      ];

      fontconfig.defaultFonts = {
        serif = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "JetBrainsMono Nerd Font" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };
    };
  };
}
