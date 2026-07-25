#!/usr/bin/env bash
# Cycle entre les profils power-profiles-daemon disponibles sur CE système.
# Ne suppose plus que les 3 profils (power-saver/balanced/performance)
# existent tous : certains systèmes (VM, laptops sans EPP) n'en ont que 2.

mapfile -t profiles < <(powerprofilesctl list | grep -oP '^\s*\*?\s*\K[a-z-]+(?=:)')
current=$(powerprofilesctl get)

# trouve l'index du profil courant dans la liste, passe au suivant (boucle)
next=""
for i in "${!profiles[@]}"; do
  if [[ "${profiles[$i]}" == "$current" ]]; then
    next_index=$(( (i + 1) % ${#profiles[@]} ))
    next="${profiles[$next_index]}"
    break
  fi
done

# fallback si jamais current n'a pas matché (ne devrait pas arriver)
if [[ -z "$next" ]]; then
  next="${profiles[0]}"
fi

powerprofilesctl set "$next"

