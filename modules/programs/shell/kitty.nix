{
  flake.modules.homeManager.kitty =
    { pkgs, config, ... }:
    {

      programs = {
        kitty = {
          enable = true;
          enableGitIntegration = true;
          font = {
            name = "Mononoki Nerd Font";
            package = pkgs.nerd-fonts.mononoki;
            size = 23;
          };
          shellIntegration.enableFishIntegration = true;
          themeFile = "OneHalfLight";
          settings = {
            shell = "fish";
          };
          keybindings = {
            "ctrl+shift+plus" = "change_font_size all +1.0";
            "ctrl+shift+minus" = "change_font_size all -1.0";
          };
        };
      };
    };
}
