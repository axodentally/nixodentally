{ inputs, ... }:
{
  flake.modules.homeManager.jadx-mcp-server =
    { pkgs, ... }:
    {
      home.packages = [
        inputs.jadx-mcp-server.packages.${pkgs.stdenv.hostPlatform.system}.jadx-mcp-server
      ];
    };
}
