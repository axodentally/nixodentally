{
  flake.modules.homeManager.helix-gj1118 =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          typescript-language-server
        ];
        languages = {
          language-server = {
            typescript-language-server = {
              command = "typescript-language-server";
              args = [ "--stdio" ];
            };
          };
          language = [
            {
              name = "javascript"; # TODO: is this just for js or also for ts? idk
              language-servers = [ "typescript-language-server" ];
            }
          ];
        };
      };
    };
}
