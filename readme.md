# Architecture — Dendritic Pattern

Config NixOS **feature-focused** : chaque fonctionnalité (NixOS + Home Manager) vit dans **un seul fichier**, et chaque machine choisit explicitement les features qu'elle active.

Basé sur [flake-parts](https://github.com/hercules-ci/flake-parts), [import-tree](https://github.com/vic/import-tree) et le [Dendritic Pattern](https://github.com/mightyiam/dendritic).

## Structure

```
nixos-config/
├── flake.nix                  # Minimal : inputs + flake-parts + import-tree
└── modules/                   # Tout est chargé automatiquement par import-tree
    ├── flake-parts.nix        # systems + option flake.modules
    ├── base.nix               # Socle commun (NixOS + HM)
    ├── desktop/               # Features du bureau + agrégat desktop.nix
    ├── services/              # Services système (docker, ssh, pipewire…)
    ├── apps/                  # Applications (alacritty, zsh, git…)
    └── hosts/                 # Une machine = un dossier (drosera, vm-test)
        └── <nom>/
            ├── default.nix    # Déclare la machine + choisit ses features
            └── _hardware.nix  # Matériel (préfixe _ = ignoré par import-tree)
```

## Principe

- **Un fichier = une feature.** Chaque fichier déclare `flake.modules.nixos.<nom>` et/ou `flake.modules.homeManager.<nom>`. Une feature mixte (ex. `niri`) garde le même nom des deux côtés.
- **Chargé ≠ activé.** `import-tree` charge tout `modules/`, mais une feature ne s'applique à une machine que si le host (ou un agrégat) l'importe explicitement.
- **Composition par import, jamais par `mkIf`** sur l'option d'un autre module. Les features qui vont ensemble sont regroupées dans un **agrégat** (ex. `desktop.nix`).
- **Pas de fusion maison.** Listes et attrsets sont fusionnés automatiquement par le système de modules Nix (`mkDefault` / `mkForce` en cas de conflit).
- **`flake.nix` ne change jamais** : ajouter une feature ou un host ne le modifie pas.

## Ajouter une feature

1. Créer `modules/<catégorie>/<feature>.nix` avec `flake.modules.nixos.<nom>` et/ou `flake.modules.homeManager.<nom>`.
2. `git add` le fichier (les flakes ignorent les fichiers non suivis).
3. L'activer en l'ajoutant à la liste d'un host ou d'un agrégat.

## Ajouter un host

1. `mkdir -p modules/hosts/<nom>` et copier le modèle de `vm-test`.
2. Adapter le nom (3 occurrences) et les listes d'imports.
3. `nixos-generate-config --show-hardware-config > _hardware.nix` (le préfixe `_` est obligatoire).


## Commandes utiles

```bash
nix flake check                            # vérifier
nixos-rebuild build --flake .#<host>       # construire sans appliquer
sudo nixos-rebuild switch --flake .#<host> # appliquer (NixOS + HM)
nixos-rebuild build-vm --flake .#<host>    # tester en VM
```