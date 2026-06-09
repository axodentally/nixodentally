{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          texlab
          zathura
          ltex-ls-plus
        ];
        languages = {
          language-server = {
            texlab = {
              config.texlab = {
                build = {
                  onSave = true;
                  executable = "latexmk";
                  forwardSearchAfter = true;
                  pdfDirectory = "build";
                };
                forwardSearch = {
                  executable = "zathura";
                  args = [
                    "--synctex-forward"
                    "%l:%c:%f"
                    "%p"
                  ];
                };
                chktex = {
                  onOpenAndSave = true;
                  onEdit = true;
                };
              };
            };
          };
          language = [
            {
              name = "latex";
              language-servers = [
                "texlab"
                "ltex-ls-plus"
              ];
            }
          ];
        };
      };
    };
}
