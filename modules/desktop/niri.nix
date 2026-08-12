{ pkgs, ... }:

{
  # active niri + toute l'intégration système (polkit, xdg-portal, dconf, fonts...)
  programs.niri.enable = true;

  # désactive SDDM si tu viens de Plasma, sinon les deux se battent pour le TTY
  # services.displayManager.sddm.enable = false;

  # Nécessaire pour que niri/wayland trouvent bien les portails
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
    config.common.default = [ "gtk" ];
  };

  environment.systemPackages = with pkgs; [
    blueman
  ];

  services.power-profiles-daemon.enable = true;
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # utile pour les apps electron (vscode, discord...)
  # (déjà géré par niri-session, mais on le laisse explicite)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
