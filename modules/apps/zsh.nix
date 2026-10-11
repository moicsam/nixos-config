{ ... }:

{
  flake.modules.nixos.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    environment.shells = [ pkgs.zsh ];
  };

  flake.modules.homeManager.zsh = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };

      oh-my-zsh = {
        enable = true;
        theme = "intheloop";
      };
    };
  };
}
