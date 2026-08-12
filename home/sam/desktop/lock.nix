{ pkgs, ... }:
let
  lockScript = pkgs.writeShellScript "lock-then-dim" ''
    # swayidle dédié à l'extinction d'écran, actif seulement pendant le lock.
    # Il détecte l'inactivité réelle (souris/clavier) et éteint après 10s,
    # se rallume au moindre mouvement, se réarme automatiquement.
    ${pkgs.swayidle}/bin/swayidle -w \
      timeout 10 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
      resume '${pkgs.niri}/bin/niri msg action power-on-monitors' &
    dim_pid=$!

    # Garantit que le swayidle enfant est bien tué quoi qu'il arrive
    # (déverrouillage normal, kill, crash, restart du service parent...)
    trap 'kill "$dim_pid" 2>/dev/null' EXIT

    # Sans -f : bloque tant que l'écran n'est pas déverrouillé
    ${pkgs.swaylock}/bin/swaylock

    ${pkgs.niri}/bin/niri msg action power-on-monitors
  '';
in
{
  # -------------------
  # Verrouillage écran
  # -------------------
  programs.swaylock = {
    enable = true;
  };

  services.swayidle =
    let
      lock = "${pkgs.swaylock}/bin/swaylock -f";
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
      enable = true;
      systemdTargets = [ "graphical-session.target" ];
      timeouts = [
        {
          timeout = 300; # 5 min d'inactivité : verrouille
          command = "${lockScript}";
        }
      ];
      events = {
        before-sleep = lock;       # fermeture du couvercle / mise en veille
        lock = "${lockScript}";    # ex: loginctl lock-session appelé manuellement
        after-resume = display "on";
      };
    };
}
