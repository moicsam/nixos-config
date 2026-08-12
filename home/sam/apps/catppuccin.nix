{ pkgs, ... }:
{
  catppuccin = {
    autoEnable = true;
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  gtk = {
    enable = true;
    # iconTheme = {
    #   name = "Papirus-Dark";
    #   package = pkgs.papirus-icon-theme;
    # };
    gtk4.theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        variant = "mocha";
      };
    };
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  # Puis, pour recolorer les dossiers de Papirus en Catppuccin :
  home.packages = [
    (pkgs.catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    })
  ];

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
  };
}
