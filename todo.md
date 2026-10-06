## Truc qui manque 
[liens de niri nix](https://wiki.nixos.org/wiki/Niri)

- [ ] secure boot
  - [ ] lanzaboot  
    Étape 2 — Ajouter l'input lanzaboote au flake
    ```nix
    # flake.nix
    {
      inputs = {
        # ... tes inputs existants
        lanzaboote = {
          url = "github:nix-community/lanzaboote/v0.4.2";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };
    }
    ```
    Puis passe-le à ta config système (dans la section outputs, là où tu construis ton nixosConfigurations), typiquement via specialArgs ou directement en modules:
    
    ```nix
    outputs = { self, nixpkgs, lanzaboote, ... }@inputs:
    {
      nixosConfigurations.ton-hostname = nixpkgs.lib.nixosSystem {
        # ...
        modules = [
          lanzaboote.nixosModules.lanzaboote
          ./configuration.nix
          # ...
        ];
      };
    };
    ```
    Étape 3 — Configuration système
      ```nix
      # configuration.nix
      { lib, pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.sbctl ];
      
        boot.loader.systemd-boot.enable = lib.mkForce false;  # lanzaboote remplace le loader
        boot.lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
      }
      ```
      Étape 4 — Générer les clés
      ```bash
      sudo nixos-rebuild switch --flake .
      sudo sbctl create-keys
      ```
      Étape 5 — Mettre le firmware en Setup Mode
      
      Redémarre, entre dans le BIOS/UEFI, et :
      
      Trouve l'option Secure Boot
      Efface les clés existantes ("Clear Secure Boot keys", "Reset to Setup Mode", ou similaire selon ton constructeur)
      Laisse Secure Boot désactivé pour l'instant
      Étape 6 — Enrôler les clés (avec Microsoft keys pour Windows)
      ```bash
      sudo sbctl enroll-keys -m
      ```
      Le -m est crucial pour toi vu que tu gardes Windows en dual-boot — sans ça, Windows sera bloqué par Secure Boot.
      
      Étape 7 — Rebuild et vérifier
      ```bash
      sudo nixos-rebuild switch --flake .
      sudo sbctl status
      ```
      Tu dois voir que le système est bien signé.
      
      Étape 8 — Réactiver Secure Boot
      
      Redémarre, réactive Secure Boot dans le BIOS, et vérifie que ça boot bien des deux côtés (NixOS et Windows).

## Modification pour la bare
- [x] bluetooth pas beau (double logot et logo pas beau)

## Truc important pas test

- [x] dual monitor
  - [x] switch de l'un a l'autre
  - [x] config quel écrant est qui et leur ordre
- [x] wifi / bluethoot
- [x] swaync
- [x] augmentre / diminuer le song avec les touches
- [x] déplacement pas top (pas de déplacement sur les autres page )

## Bug a fix important

- [x] Lock fonctionne pas depuis wlogout
- [x] song fonctionne mais j'ai pas de rétroaction
- [x] nwg-display fonctionne pas car le fichier niri/config.kdl est own par le store et que je suis pas capable d'ajouter la ligne include "monitor.kdl"
