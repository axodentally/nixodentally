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
          permissions = [
            {
              action = "external_directory";
              resource = "*";
              effect = "ask";
            }
            {
              action = "external_directory";
              resource = "/tmp/opencode/*";
              effect = "allow";
            }
            {
              action = "read";
              resource = "/tmp/opencode/*";
              effect = "allow";
            }
            {
              action = "edit";
              resource = "/tmp/opencode/*";
              effect = "allow";
            }
          ];
        };
      };
    };
}
