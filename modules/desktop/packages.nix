{ ... }:

{
  flake.modules.homeManager.desktop-packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      niri
      swaybg
      grim
      slurp
      wl-clipboard
      cliphist
      pavucontrol
      networkmanagerapplet
      brightnessctl
      playerctl
      nwg-displays
      xwayland-satellite
    ];
  };
}
