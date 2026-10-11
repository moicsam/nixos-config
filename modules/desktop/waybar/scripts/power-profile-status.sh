#!/usr/bin/env bash
# Affiche le profil courant en JSON pour le module custom waybar

current=$(powerprofilesctl get)

case "$current" in
  power-saver)
    icon=""
    text="Éco"
    ;;
  balanced)
    icon="󰗑"
    text="Équilibré"
    ;;
  performance)
    icon=""
    text="Perf"
    ;;
  *)
    icon="?"
    text="Inconnu"
    ;;
esac

printf '{"text": "%s %s", "tooltip": "Profil : %s\\nClic gauche : changer de profil"}\n' "$icon" "$text" "$current"
