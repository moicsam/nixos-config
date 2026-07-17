{ config, pkgs, ... }:

{
  services.openssh.enable = true;

  systemd.user.services.ssh-agent = {
    description = "SSH Agent";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig.Type = "forking";
    script = ''
      ${pkgs.openssh}/bin/ssh-agent -D -a $XDG_RUNTIME_DIR/ssh-agent.socket
    '';
    environment = {
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
    };
  };
}
