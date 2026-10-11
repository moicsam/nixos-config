{ ... }:

{
  # swaylock a besoin d'un service PAM côté système
  flake.modules.nixos.lock = {
    security.pam.services.swaylock = { };
  };

  flake.modules.homeManager.lock = { pkgs, ... }: {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;
        datestr = "%d-%m-%Y";
        timestr = "%H:%M:%S";
        font-size = 28;
        indicator-radius = 100;
        screenshots = true;
        effect-blur = "7x5";
      };
    };

    services.swayidle =
    let
      lock = "${pkgs.swaylock-effects}/bin/swaylock --daemonize";
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
      enable = true;
      systemdTargets = [ "graphical-session.target" ];
      timeouts = [
        {
          timeout = 300;
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
        }
        {
          timeout = 305;
          command = lock;
        }
        {
          timeout = 310;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 315;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = {
        before-sleep = "${lock}; ${display "off"}";
        lock = "${lock}; ${display "off"}";
        after-resume = display "on";
        unlock = display "on";
      };
    };
  };
}
