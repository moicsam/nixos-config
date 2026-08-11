{ ... }:

{
  # -------------------
  # Barre de statut
  # -------------------
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 34;
      spacing = 4;

      modules-left = [ "custom/nix-menu" "cpu" "memory" "niri/window" ];
      modules-center = [ "niri/workspaces" ];
      modules-right = [
        "custom/power-profile"
        "network"
        "bluetooth"
        "backlight"
        "battery"
        "custom/control-center"
        "clock"
      ];

      # ---- Gauche : infos system ----

      "custom/nix-menu" = {
        format = "";
        tooltip-format = "Menu système (logout / power off / lanceur)";
        on-click = "wlogout -b 3";
      };

      cpu = {
        interval = 2;
        format = " {usage}%";
        tooltip = true;
      };

      memory = {
        interval = 2;
        format = " {percentage}%";
        tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB utilisés";
      };

      "niri/window" = {
        format = "{}";
        icon = true;
        icon-size = 18;
        max-length = 30;
        separate-outputs = true;
      };


      # ---- Centre : espaces de travail niri ----
      "niri/workspaces" = {
        format = "{index}";
        on-click = "activate";
      };

      # ---- Droite ----

      # Profil énergie : clic gauche = cycle éco/équilibré/perf
      "custom/power-profile" = {
        exec = "~/.config/waybar/scripts/power-profile-status.sh";
        return-type = "json";
        interval = 5;
        on-click = "~/.config/waybar/scripts/power-profile-cycle.sh";
        signal = 8; # permet un refresh instantané au clic, voir note plus bas
      };

      network = {
        format-wifi = "{icon} {signalStrength}%";
        format-ethernet = " {ipaddr}";
        format-disconnected = "󰤭";
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        tooltip-format-wifi = "{essid} - {ifname} via {gwaddr}";
        tooltip-format-ethernet = "{ifname} via {gwaddr}";
        on-click = "nm-connection-editor";
      };

      bluetooth = {
        format = " {status}";
        format-connected = " {device_alias}";
        format-connected-battery = " {device_alias} ({device_battery_percentage}%)";
        tooltip-format = "{controller_alias}\t{controller_address}";
        on-click = "blueman-manager";
      };

      # Luminosité
      backlight = {
        format = "☀ {percent}%";
        on-scroll-up = "brightnessctl set 5%+";
        on-scroll-down = "brightnessctl set 5%-";
      };

      battery = {
        interval = 10;
        states = {
          warning = 25;
          critical = 10;
        };
        format = "{icon}  {capacity}%";
        format-charging = " {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };

      # Bouton qui ouvre le control center swaync (musique via MPRIS, notifications, réglages rapides)
      "custom/control-center" = {
        format = "";
        tooltip-format = "Ouvrir le centre de contrôle";
        on-click = "swaync-client -t -sw";
      };

      tray = {
        spacing = 8;
      };

      clock = {
        format = "{:%H:%M   %d/%m}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          weeks-pos = "left";
          on-scroll = 1;
        };
        on-click-right = "mode";
      };
    };

    style = builtins.readFile ./waybar-style.css;
  };

  # Copie les scripts custom dans ~/.config/waybar/scripts
  home.file.".config/waybar/scripts/power-profile-cycle.sh" = {
    source = ./scripts/power-profile-cycle.sh;
    executable = true;
  };
  home.file.".config/waybar/scripts/power-profile-status.sh" = {
    source = ./scripts/power-profile-status.sh;
    executable = true;
  };

  # Force le mode d'injection : catppuccin doit prepend ses couleurs
  # à notre style.css (sinon rien ne s'applique du tout)
  catppuccin.waybar.mode = "prependImport";
}
