{ config, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with config.flake.modules.nixos; [
      niri
      greetd
      fonts
      lock
      pipewire
      bluetooth
      udisks
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = with config.flake.modules.homeManager; [
      niri
      waybar
      lock
      swaync
      swayosd
      wallpaper
      fuzzel
      wlogout
      alacritty
      catppuccin
      packages
      desktop-packages
      udisks
    ];
  };
}
