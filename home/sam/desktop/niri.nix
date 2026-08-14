{ config, lib, ... }:
{
  # -------------------
  # Config niri
  # -------------------
  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = "fr";
      variant = "bepo";
    };

    input = {
      touchpad = {
        tap = true;
        natural-scroll = true;
        scroll-method = "two-finger";
        accel-speed = 0.3;             # vitesse du curseur
        dwt = true;                    # disable-while-typing
      };
    };

    binds = {
      ############################################
      # Lancement d'applications
      ############################################
      "Mod+Return".action.spawn = "alacritty";
      "Mod+D".action.spawn = "fuzzel";
      "Mod+Q".action.close-window = {};
      "Mod+Ctrl+E".action.quit = {};
      "Mod+Ctrl+L".action.spawn = [ "loginctl" "lock-session" ];

      ############################################
      # Focus — navigation vim hjkl
      ############################################
      "Mod+C".action.focus-column-left = {};
      "Mod+R".action.focus-column-right = {};
      "Mod+T".action.focus-window-down = {};
      "Mod+S".action.focus-window-up = {};

      # Flèches en alias
      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};

      # Premier / dernier de la ligne
      "Mod+Home".action.focus-column-first = {};
      "Mod+End".action.focus-column-last = {};

      # Changer d'écran
      "Mod+Shift+C".action.focus-monitor-left = {};
      "Mod+Shift+R".action.focus-monitor-right = {};

      ############################################
      # Déplacer la fenêtre focus — Ctrl+hjkl
      ############################################
      "Mod+Ctrl+C".action.move-column-left = {};
      "Mod+Ctrl+R".action.move-column-right = {};
      "Mod+Ctrl+T".action.move-window-down = {};
      "Mod+Ctrl+S".action.move-window-up = {};

      # Vers un autre moniteur (déplace la fenêtre)
      "Mod+Ctrl+Shift+C".action.move-column-to-monitor-left = {};
      "Mod+Ctrl+Shift+R".action.move-column-to-monitor-right = {};

      ############################################
      # Resize — Alt+hjkl (évite le petit doigt sur Shift)
      ############################################
      "Mod+Alt+C".action.set-column-width = "-10%";
      "Mod+Alt+R".action.set-column-width = "+10%";
      "Mod+Alt+T".action.set-window-height = "-10%";
      "Mod+Alt+S".action.set-window-height = "+10%";

      ############################################
      # Layouts multi-fenêtres : 1 / 2 / 4 fenêtres à l'écran
      ############################################
      "Mod+F".action.fullscreen-window = {}; # cache tout le reste
      "Mod+Ctrl+F".action.maximize-column = {};
      "Mod+O".action.switch-preset-column-width = {}; # Cycle entre les largeurs prédéfinies (voir bloc layout plus bas)

      "Mod+Comma".action.consume-window-into-column = {};   # ajoute la fenêtre focus voisine à la colonne
      "Mod+Period".action.expel-window-from-column = {};    # ressort la fenêtre focus de la colonne

      ############################################
      # Workspaces
      ############################################
      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};

      # Alias avec T/S (bépo) pour switcher de workspace sans passer par waybar
      # (Mod+Alt+T/S est déjà pris par le resize, on utilise Mod+Shift ici)
      "Mod+Shift+T".action.focus-workspace-down = {};
      "Mod+Shift+S".action.focus-workspace-up = {};
      "Mod+Ctrl+Shift+T".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+Shift+S".action.move-column-to-workspace-up = {};

      # Accès direct workspace 1-9 (comme sur i3/sway)
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;

      ############################################
      # Flottant / tiling toggle
      ############################################
      "Mod+Shift+Space".action.toggle-window-floating = {};
      "Mod+Space".action.switch-focus-between-floating-and-tiling = {};

      ############################################
      # Screenshot
      ############################################
      "Print".action.screenshot = {};
      "Mod+Print".action.screenshot-window = {};
      "Ctrl+Print".action.screenshot-screen = {};

      ############################################
      # Volume / luminosité — via swayosd (affiche un OSD visuel)
      # nécessite : services.swayosd.enable = true; dans la config système
      ############################################
      "XF86AudioRaiseVolume".action.spawn = [ "swayosd-client" "--output-volume" "raise" ];
      "XF86AudioLowerVolume".action.spawn = [ "swayosd-client" "--output-volume" "lower" ];
      "XF86AudioMute".action.spawn = [ "swayosd-client" "--output-volume" "mute-toggle" ];
      "XF86MonBrightnessUp".action.spawn = [ "swayosd-client" "--brightness" "raise" ];
      "XF86MonBrightnessDown".action.spawn = [ "swayosd-client" "--brightness" "lower" ];

      ############################################
      # Verrouillage écran (nécessite swaylock ou équivalent)
      ############################################
      "Mod+Escape".action.spawn = [ "loginctl" "lock-session" ];

      "Mod+Tab".action.toggle-overview = {};
      "Mod+Shift+Comma".action.show-hotkey-overlay = {};  # Mod+? en pratique (le ? est sur Shift+')
    };

    # prefer-no-csd = true;

    layout = {
      preset-column-widths = [
        { proportion = 0.5; }   # 1/2 écran → "2 fenêtres"
        { proportion = 1.0; }   # plein écran → "1 fenêtre"
      ];
      default-column-width = { proportion = 0.5; };
      gaps = 12;

      center-focused-column = "never";

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#cba6f7";   # mauve Catppuccin Mocha
        inactive.color = "#45475a"; # gris Catppuccin Mocha
      };

      border = {
        enable = true;
        width = 2;
        active.color = "#89b4fa";
        inactive.color = "#313244";
      };

      shadow = {
        enable = true;
        softness = 30;
        spread = 4;
        offset = { x = 0; y = 5; };
        color = "#11111b80"; # crust Catppuccin, semi-transparent
      };

      struts = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
    };
  };

  # On laisse niri-flake désactivé sur config.kdl lui-même,
    # mais on récupère son contenu généré pour l'écrire ailleurs.
    xdg.configFile.niri-config.enable = lib.mkForce false;
    xdg.configFile."niri/config-base.kdl".text = config.programs.niri.finalConfig;

    home.activation.niriConfigInclude = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${config.xdg.configHome}/niri"
      if [ ! -e "${config.xdg.configHome}/niri/config.kdl" ] || [ -L "${config.xdg.configHome}/niri/config.kdl" ]; then
        rm -f "${config.xdg.configHome}/niri/config.kdl"
        echo 'include "config-base.kdl"' > "${config.xdg.configHome}/niri/config.kdl"
      fi
    '';
}
