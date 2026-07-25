{ ... }:
{
  # -------------------
  # Config niri
  # -------------------
  programs.niri.settings = {
    input.keyboard.xkb = {
      layout = "fr"; # adapte ton layout clavier
      variant = "bepo";
    };

    input = {
      touchpad = {
        tap = true;                    # taper pour cliquer
        natural-scroll = true;         # scroll "naturel" façon macOS (sens inversé)
        scroll-method = "two-finger";  # scroll à 2 doigts (c'est ce que tu demandes)
        accel-speed = 0.3;             # vitesse du curseur, ajuste selon ton goût
        dwt = true;                    # disable-while-typing, évite les clics accidentels en tapant
      };
    };

    outputs."eDP-1".scale = 1.0; # adapte le nom de sortie et l'échelle

    binds = {
      ############################################
      # Lancement d'applications
      ############################################
      "Mod+Return".action.spawn = "alacritty";
      "Mod+D".action.spawn = "fuzzel";
      "Mod+Q".action.close-window = {};
      "Mod+Shift+E".action.quit = {};
      "Mod+Shift+Q".action.spawn = [ "wlogout" ]; # menu power (logout/reboot/shutdown) — installe wlogout si pas déjà fait

      ############################################
      # Focus — navigation vim hjkl
      ############################################
      "Mod+H".action.focus-column-left = {};
      "Mod+L".action.focus-column-right = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};

      # Flèches en alias (pour les moments où tu penses pas vim)
      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};

      # Premier / dernier de la ligne
      "Mod+Home".action.focus-column-first = {};
      "Mod+End".action.focus-column-last = {};

      ############################################
      # Déplacer la fenêtre focus — Ctrl+hjkl
      ############################################
      "Mod+Ctrl+H".action.move-column-left = {};
      "Mod+Ctrl+L".action.move-column-right = {};
      "Mod+Ctrl+J".action.move-window-down = {};
      "Mod+Ctrl+K".action.move-window-up = {};

      # Vers un autre moniteur
      "Mod+Ctrl+Shift+H".action.move-column-to-monitor-left = {};
      "Mod+Ctrl+Shift+L".action.move-column-to-monitor-right = {};

      ############################################
      # Resize — Alt+hjkl (évite le petit doigt sur Shift)
      ############################################
      "Mod+Alt+H".action.set-column-width = "-10%";
      "Mod+Alt+L".action.set-column-width = "+10%";
      "Mod+Alt+J".action.set-window-height = "-10%";
      "Mod+Alt+K".action.set-window-height = "+10%";

      ############################################
      # Layouts multi-fenêtres : 1 / 2 / 4 fenêtres à l'écran
      ############################################
      # 1 = plein écran (une seule colonne prend toute la largeur)
      "Mod+1".action.set-column-width = "100%";
      # 2 = moitié d'écran (2 colonnes visibles)
      "Mod+2".action.set-column-width = "50%";
      # 3 = tiers d'écran (3 colonnes visibles, ~utile grands écrans)
      "Mod+3".action.set-column-width = "33%";
      # 4 = quart d'écran (4 colonnes visibles)
      "Mod+4".action.set-column-width = "25%";

      # Vrai fullscreen (cache tout le reste, pas juste 100% de largeur)
      "Mod+F".action.fullscreen-window = {};
      # Maximise la colonne (garde le flow niri, diffère du fullscreen strict)
      "Mod+Ctrl+F".action.maximize-column = {};
      # Cycle entre les largeurs prédéfinies (voir bloc layout plus bas)
      "Mod+R".action.switch-preset-column-width = {};
      # Centre la colonne focus à l'écran
      "Mod+C".action.center-column = {};

      # Empiler/déplier une fenêtre dans la colonne courante (pour le "4 fenêtres"
      # tu combines souvent 2 colonnes x 2 fenêtres empilées chacune)
      "Mod+Comma".action.consume-window-into-column = {};   # ajoute la fenêtre focus voisine à la colonne
      "Mod+Period".action.expel-window-from-column = {};    # ressort la fenêtre focus de la colonne

      ############################################
      # Workspaces
      ############################################
      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};

      # Accès direct workspace 1-9 (comme sur i3/sway)
      # "Mod+1".action.focus-workspace = 1;
      # "Mod+2".action.focus-workspace = 2;
      # "Mod+3".action.focus-workspace = 3;
      # "Mod+4".action.focus-workspace = 4;
      # "Mod+Shift+1".action.move-column-to-workspace = 1;
      # "Mod+Shift+2".action.move-column-to-workspace = 2;
      # "Mod+Shift+3".action.move-column-to-workspace = 3;
      # "Mod+Shift+4".action.move-column-to-workspace = 4;

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
      # Volume / luminosité (nécessite pactl / brightnessctl installés)
      ############################################
      "XF86AudioRaiseVolume".action.spawn = [ "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%" ];
      "XF86AudioLowerVolume".action.spawn = [ "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%" ];
      "XF86AudioMute".action.spawn = [ "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle" ];
      "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "+5%" ];
      "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "5%-" ];

      ############################################
      # Verrouillage écran (nécessite swaylock ou équivalent)
      ############################################
      "Mod+Escape".action.spawn = "swaylock";

      "Mod+Tab".action.toggle-overview = {};
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};  # Mod+Shift+? en pratique (le ? est sur Shift+/)
    };

    # prefer-no-csd = true;

    layout = {
      preset-column-widths = [
        { proportion = 0.25; }  # 1/4 écran → "4 fenêtres"
        { proportion = 0.33; }  # 1/3 écran
        { proportion = 0.5; }   # 1/2 écran → "2 fenêtres"
        { proportion = 1.0; }   # plein écran → "1 fenêtre"
      ];
      default-column-width = { proportion = 0.5; };
      gaps = 12;

      center-focused-column = "never";

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#89b4fa";   # bleu Catppuccin Mocha
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
}
