{ ... }: {
  # -------------------
  # Control center : swaync remplace mako
  # (donne un vrai panneau avec MPRIS/musique + notifications + boutons rapides)
  # -------------------
  services.swaync = {
    enable = true;
    settings = {
      widgets = [
        "mpris"
        "buttons-grid"
        "volume"
        "backlight"
        "title"
        "dnd"
        "notifications"
      ];
      widget-config = {
        mpris = {
          image-size = 64;
        };
        buttons-grid = {
          actions = [
            {
              label = "";
              command = "blueman-manager";
            }
            {
              label = "";
              command = "nm-connection-editor";
            }
            {
              label = "";
              command = "pavucontrol";
            }
          ];
        };
      };
    };
  };
}
