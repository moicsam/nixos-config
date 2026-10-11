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
      brave
      jdk17
      nodejs
      wget
      docker-buildx
      bruno
      neovim
      plantuml
      duc
      libreoffice-qt
      zettlr
      nemo

      wireguard-tools
      nmap
      wireshark
      tcpdump
      netcat
      gdb
      pwntools
      checksec
      wimlib
      burpsuite
      sqlmap
      john
      hashcat
      binwalk
      exiftool
      tmux
      python3
    ];
  };
}
