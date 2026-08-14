{ inputs, ... }:

{
  home.username = "sam";
  home.homeDirectory = "/home/sam";

  imports = [
    ./apps/alacritty.nix
    ./apps/zsh.nix
    ./apps/git.nix
    ./apps/catppuccin.nix
    ./apps/zed-editor.nix
    ./apps/fuzzel.nix
    ./apps/wlogout.nix
    ./apps/udisk.nix
    ./apps/keepassxc.nix
    ./desktop/default.nix
    ./packages.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  services.syncthing.enable = true;

  home.stateVersion = "25.11";
}
