{ ... }:
{
  # -------------------
  # Control center : swaync
  # -------------------
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-width = 400;
      control-center-height = 600;
      notification-window-width = 400;

      widgets = [
        "buttons-grid"
        "volume"
        "backlight"
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];

      widget-config = {
        mpris = {
          image-size = 64;
          blur = true;
        };

        buttons-grid = {
          actions = [
            {
              label = "";
              command = "pavucontrol";
            }
          ];
        };

        volume = {
          label = "";
        };

        backlight = {
          label = "";
        };

        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };

        dnd = {
          text = "Do Not Disturb";
        };
      };
    };
  };
}
