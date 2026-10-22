{
  flake.modules.homeManager.opencode =
    { pkgs, ... }:
    {
      programs.opencode = {
        enable = true;
        enableMcpIntegration = true;
        package = pkgs.unstable.opencode;
        settings = {
          plugins = [
            "opencode-tps-meter@latest"
          ];
        };
      };
    };
}
