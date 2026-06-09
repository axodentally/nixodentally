{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          zathura # pdf viewer, may be obsolete
          ltex-ls-plus
          tinymist
          typstyle # also check if obsolete
        ];
        settings = {
          keys = {
            normal = {
              # for Typst, not optimal but a way.
              C-p = [ ":sh typst watch ./*.typ & zathura ./*.pdf" ];
            };
          };
        };
        languages = {
          language-server = {
            tinymist = {
              command = "tinymist";
              config = {
                exportPdf = "onType";
                outputPath = "$root/target/$dir/$name";
                formatterMode = "typstyle";
                formatterPrintWidth = 80;
                lint = {
                  enabled = true;
                  when = "onType";
                };
              };
            };
          };
          language = [
            {
              name = "typst";
              # auto-format = false;
              # formatter.command = "${pkgs.typstfmt}/bin/typstfmt";
              language-servers = [ "tinymist" ];
            }
          ];
        };

      };
    };
}
