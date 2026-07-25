{ pkgs, ... }:
{
  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  gtk = {
    enable = true;  # <-- essentiel, sans ça catppuccin.gtk ne fait rien
    iconTheme.name = "Papirus-Dark"; # géré par catppuccin si icon.enable
    gtk4.theme = null;
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  # pour que Qt suive le même thème (sinon apps Qt restent blanches)
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "gtk4";
  };

  # curseur cohérent
  home.pointerCursor = {
    enable = true;
    package = pkgs.catppuccin-cursors.mochaMauve;
    name = "catppuccin-mocha-mauve-cursors";
    size = 24;
    # gtk.enable = true;
    # x11.enable = true;
  };
}
