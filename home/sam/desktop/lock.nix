{ pkgs, ... }:
{
  programs.swaylock.enable = true;
  services.swayidle =
  let
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in
  {
    enable = true;
    systemdTargets = [ "graphical-session.target" ];
    timeouts = [
         {
           timeout = 300; # in seconds
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
}
