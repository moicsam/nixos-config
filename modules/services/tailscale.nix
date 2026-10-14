{ ... }:
{
  flake.modules.nixos.tailscale = {
    services.tailscale = {
      enable = true;
      openFirewall = true;            # UDP 41641, connexions directes
      useRoutingFeatures = "client";  # "server" si exit node / subnet router
    };

    # Tout ce qui arrive via Tailscale est autorisé (donc SSH aussi)
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
