{ ... }:
{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      openFirewall = false; # 22 n'est pas exposé hors Tailscale
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
