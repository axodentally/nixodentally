{
  flake.modules.homeManager.helix-gj1118 =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          gopls
        ];
        languages = {
          language-server = {
            gopls = {
              command = "${pkgs.gopls}/bin/gopls";
              args = [ "serve" ];
            };
          };
          language = [
            {
              name = "go";
              language-servers = [ "gopls" ];
              formatter = {
                command = "${pkgs.go}/bin/gofmt";
              };
            }
          ];
        };
      };
    };
}
