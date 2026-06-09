{
  # description = "JADX MCP Server - NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    jadx-src = {
      url = "git+https://github.com/zinja-coder/jadx-mcp-server?rev=e27e99185690d8024a7c7b1a87823016c589be0d";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      jadx-src,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python313;

        pythonDeps = with pkgs.python313Packages; [
          httpx
          requests
          mcp
          fastmcp
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            python
            pkgs.uv
          ]
          ++ pythonDeps;
          shellHook = ''
            echo "jadx-mcp-server dev shell"
            echo "Python: $(python3 --version)"
          '';
        };

        packages.default = pkgs.python313Packages.buildPythonApplication {
          pname = "jadx-mcp-server";
          version = "6.2.0";
          src = jadx-src;

          pyproject = true;
          build-system = [ pkgs.python313Packages.setuptools ];

          propagatedBuildInputs = pythonDeps;

          patches = [ ./patches/0004-add-packages-src.patch ];

          # nixpkgs fastmcp is 2.14.5 but works fine at runtime;
          # disable the version-string check to avoid a false failure.
          pythonRelaxDeps = true;

          postPatch = ''
            chmod +x jadx_mcp_server.py
          '';

          meta = with pkgs.lib; {
            description = "MCP server for JADX decompiler integration";
            license = licenses.asl20;
            platforms = platforms.all;
            mainProgram = "jadx_mcp_server";
          };
        };

        packages.jadx-mcp-server = self.packages.${system}.default;
      }
    );
}
