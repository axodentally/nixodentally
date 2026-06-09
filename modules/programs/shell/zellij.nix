{
  flake.modules.homeManager.zellij =
    { pkgs, ... }:
    {
      programs.zellij = {
        package = pkgs.unstable.zellij;
        enable = true;
        enableFishIntegration = true;
        attachExistingSession = true;
        settings = {
          theme = "catppuccin-latte";
          default_shell = "fish";
        };
      };
    };
}
