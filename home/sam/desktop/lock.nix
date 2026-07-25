{ ... }:
{
  # -------------------
  # Verrouillage écran
  # -------------------
  programs.swaylock = {
    enable = true;
  };
  services.swayidle.enable = true;
}
