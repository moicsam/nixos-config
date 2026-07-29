{ ... }:
{
  # -------------------
  # Verrouillage écran
  # -------------------
  programs.swaylock = {
    enable = true;
  };
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300; # 5 minutes
        command = "swaylock -f";
      }
    ];
    events = {
      "lock" = "swaylock -f";
    };
  };
}
