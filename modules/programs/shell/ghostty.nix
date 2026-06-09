{
  flake.modules.homeManager.ghostty =
    { pkgs, config, ... }:
    {
      programs = {
        ghostty = {
          enable = true;
          enableFishIntegration = true;
          settings = {
            command = "/etc/profiles/per-user/${config.home.username}/bin/fish --login --interactive";
            font-family = "Mononoki Nerd Font";
            font-size = "11";
            theme = "light:Monokai Pro Light Sun,dark:Monokai Pro";
            keybind = [
              "shift+alt+l=goto_split:next"
              "shift+alt+h=goto_split:previous"
            ];
          };
        };
      };
      fonts.fontconfig.enable = true;
      home.packages = with pkgs; [
        nerd-fonts.code-new-roman
        nerd-fonts.mononoki
      ];
    };
}
