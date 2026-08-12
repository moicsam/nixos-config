{ pkgs, ... }:
let
  lockScript = pkgs.writeShellScript "lock-then-dim" ''
    # Empêche les instances multiples de swaylock de s'empiler
    if ${pkgs.procps}/bin/pgrep -x swaylock > /dev/null; then
      exit 0
    fi

    ${pkgs.swayidle}/bin/swayidle -w \
      timeout 10 '${pkgs.niri}/bin/niri msg action power-off-monitors' \
      resume '${pkgs.niri}/bin/niri msg action power-on-monitors' &
    dim_pid=$!

    trap 'kill "$dim_pid" 2>/dev/null' EXIT

    ${pkgs.swaylock}/bin/swaylock

    ${pkgs.niri}/bin/niri msg action power-on-monitors
  '';
in
{
  programs.swaylock = {
    enable = true;
  };

  services.swayidle =
    let
      lock = "${pkgs.swaylock}/bin/swaylock -f";
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
      enable = true;
      systemdTargets = [ "graphical-session.target" ];
      timeouts = [
        {
          timeout = 300;
          command = "${lockScript}";
        }
      ];
      events = {
        before-sleep = lock;
        lock = "${lockScript}";
        after-resume = display "on";
      };
    };
}
