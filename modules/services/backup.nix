{ ... }:
{
  flake.modules.nixos.backup = { pkgs, config, ... }:
    let
      kloset = "/root/.plakar";

      backupScript = pkgs.writeShellScript "plakar-backup-radicale" ''
        set -euo pipefail
        export PLAKAR_PASSPHRASE="$(cat "$CREDENTIALS_DIRECTORY/passphrase")"

        # Créer le kloset s'il n'existe pas encore
        if ! ${pkgs.plakar}/bin/plakar at ${kloset} info >/dev/null 2>&1; then
          ${pkgs.plakar}/bin/plakar at ${kloset} create
        fi

        # Backup des données Radicale
        ${pkgs.plakar}/bin/plakar at ${kloset} backup /var/lib/radicale/collections
      '';
    in
    {
      age.secrets.backup_passphrase.file = ../../secrets/backup_passphrase.age;

      environment.systemPackages = [ pkgs.plakar ];

      systemd.services.plakar-backup-radicale = {
        description = "Backup quotidien des données Radicale via Plakar";
        # pas indispensable vu que les .ics sont écrits même si radicale n'est pas actif
        after = [ "radicale.service" ];
        serviceConfig = {
          Type = "oneshot";
          # force systemd à définir $HOME=/root
          User = "root";
          Environment = [ "HOME=/root" ];
          LoadCredential = "passphrase:${config.age.secrets.backup_passphrase.path}";
          ExecStart = backupScript;
        };
      };

      systemd.timers.plakar-backup-radicale = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "*-*-* 03:00:00"; # tous les jours à 3h du matin
          Persistent = true;             # rattrape les runs manqués (machine éteinte)
        };
      };
    };
}
