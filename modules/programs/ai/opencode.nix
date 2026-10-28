{
  flake.modules.homeManager.opencode =
    { pkgs, ... }:
    {
      programs.opencode = {
        enable = true;
        enableMcpIntegration = true;
        package = pkgs.unstable.opencode;

        # tools for the read-pdf skill (pdfinfo, pdftotext, pdftoppm);
        # wrapped onto opencode's PATH only
        extraPackages = [ pkgs.poppler-utils ];

        settings = {
          plugins = [
            "opencode-tps-meter@latest"
          ];
          permissions = [
            {
              action = "external_directory";
              resource = "*";
              effect = "ask";
            }
            {
              action = "external_directory";
              resource = "/tmp/opencode/*";
              effect = "allow";
            }
            {
              action = "read";
              resource = "/tmp/opencode/*";
              effect = "allow";
            }
            {
              action = "edit";
              resource = "/tmp/opencode/*";
              effect = "allow";
            }
          ];
        };
      };
    };
}
