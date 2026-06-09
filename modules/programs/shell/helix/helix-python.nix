{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          basedpyright
          ruff
        ];
        languages = {
          language-server = {
            # Python
            ruff = {
              command = "${pkgs.ruff}/bin/ruff";
              args = [ "server" ];
            };
            basedpyright = {
              command = "basedpyright-langserver";
              args = [ "--stdio" ];
              config = {
                basedpyright.analysis = {
                  autoImportCompletion = true;
                };
              };
            };
          };
          language = [
            {
              name = "python";
              language-servers = [
                "ruff"
                "basedpyright"
              ];
              auto-format = true;
            }

          ];
        };

      };
    };
}
