{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Utilitaires système
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

    # Outils CTF 
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
}
