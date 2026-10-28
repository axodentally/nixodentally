{
  flake.modules.homeManager.mcp-nixos =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mcp-nixos
      ];

      programs.mcp = {
        enable = true;
        servers = {
          mcp-nixos = {
            command = "mcp-nixos";
          };
        };
      };
    };

}
