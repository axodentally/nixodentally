{
  inputs,
  ...
}:
{
  flake.modules.homeManager.advanced-git-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        unstable.git-spice
      ];
      programs = {
        delta = {
          enable = true;
          enableGitIntegration = true;
        };

        gh-dash = {
          enable = true;
          package = pkgs.unstable.gh-dash;
          settings = {
            theme = {
              colors = {
                text = {
                  primary = "12";
                  secondary = "10";
                  faint = "11";
                };
                border = {
                  primary = "4";
                };
              };
            };
          };
        };
      };
    };
}
