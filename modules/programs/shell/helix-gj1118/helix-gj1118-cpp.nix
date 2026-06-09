{
  flake.modules.homeManager.helix-gj1118 =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          clang-tools
        ];
        languages = {
          language-server = {
            clangd = {
              command = "${pkgs.clang-tools}/bin/clangd";
              clangd.fallbackFlags = [ "-std=c++2b" ];
            };
          };
          language = [
            {
              name = "cpp";
              auto-format = false;
              formatter = {
                command = "${pkgs.clang-tools}/bin/clang-format";
                args = [ "-i" ];
              };
            }
          ];
        };

      };
    };
}
