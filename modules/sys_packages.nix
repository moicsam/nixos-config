{ ... }:

{
  flake.modules.nixos.packages = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    nixpkgs.config.permittedInsecurePackages = [
      "electron-39.8.10"
    ];

    environment.systemPackages = with pkgs; [
      unzip
      htop
      zsh
      wget
      docker-buildx
      neovim
      duc
      wireguard-tools
      netcat
      tmux
      gdb
      apacheHttpd
    ];
  };
}
