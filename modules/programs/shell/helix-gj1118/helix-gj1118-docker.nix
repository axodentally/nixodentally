{
  flake.modules.homeManager.helix-gj1118 =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          docker-language-server
        ];
        languages = {
          language-server = {
            docker-language-server = {
              command = "docker-language-server";
              args = [
                "start"
                "--stdio"
              ];
            };
          };
          language = [
            {
              name = "dockerfile";
              language-servers = [ "docker-language-server" ];
              auto-format = true;
            }
            # For Docker Compose files
            {
              name = "docker-compose";
              scope = "source.yaml";
              language-servers = [ "docker-language-server" ];
              file-types = [
                "docker-compose.yml"
                "docker-compose.yaml"
              ];
            }
          ];
        };
      };
    };
}
