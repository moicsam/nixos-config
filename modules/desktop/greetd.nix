{ ... }:

{
  flake.modules.nixos.greetd = { pkgs, ... }: {
    users.users.greeter = {
      isSystemUser = true;
      group = "greeter";
      shell = pkgs.bash;
    };

    users.groups.greeter = {};

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
          user = "greeter";
        };
      };
    };
  };
}
