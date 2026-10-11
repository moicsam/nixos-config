{ ... }:

{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Samuel Klein-Bichain";
          email = "samuel.kleinbichain@proton.me";
        };
      };
    };
  };
}
