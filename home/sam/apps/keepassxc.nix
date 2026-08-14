{ ... }:
{
  programs.keepassxc = {
    autostart = true;
    enable = true;
  };

  xdg.autostart.enable = true; # Enable creation of XDG autostart entries.
}
