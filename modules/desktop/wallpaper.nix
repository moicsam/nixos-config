{ ... }:

{
  flake.modules.homeManager.wallpaper = { pkgs, ... }:
  let
    wallpaper = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/e0cf0eb237dc5baba86661a3572b20a6183c1876/wallpapers/nix-wallpaper-nineish-catppuccin-mocha-alt.png";
      sha256 = "4e10eb648248c8ed837485b8d6c57a898c8236133cf5cc07afc97a0c07db5e32";
    };
  in
  {
    # Rend le wallpaper disponible à un chemin stable dans le home
    home.file.".local/share/wallpapers/catppuccin-mocha.png".source = wallpaper;

    programs.niri.settings.spawn-at-startup = [
      {
        command = [
          "${pkgs.swaybg}/bin/swaybg"
          "-i"
          "${wallpaper}"
          "-m"
          "fill"
        ];
      }
    ];
  };
}
