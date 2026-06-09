{
  flake.modules.homeManager.helix-gj1118 =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          markdown-oxide
        ];
        languages = {
          language-server = {
            markdown-oxide = {
              command = "markdown-oxide";
              args = [ "--stdio" ];
            };
          };
          language = [
            {
              name = "markdown";
              language-servers = [ "markdown-oxide" ];
            }
          ];
        };
      };
    };
}
