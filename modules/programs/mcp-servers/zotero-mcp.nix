{ inputs, ... }:
let
  # nixpkgs tree carrying the zotero-mcp packaging expressions
  # (github:NixOS/nixpkgs/pull/563759) until the PR is merged.
  # Only the three expressions (zotero-mcp, pdf-inspector, pyzotero) are
  # borrowed from it; every dependency is built from the pinned
  # nixpkgs-unstable package set, so this stays secure and updated.
  # TODO: remove this module's overlay and use pkgs.zotero-mcp directly
  # once the PR lands in nixos-unstable.
  prTree = inputs.nixpkgs-zotero-mcp;
in
{
  flake.modules.nixos.zotero-mcp = {
    nixpkgs.overlays = [
      (final: _prev: {
        zotero-mcp-pkgs = import inputs.nixpkgs-unstable {
          inherit (final) config;
          system = final.stdenv.hostPlatform.system;
          overlays = [
            (ufinal: uprev:
              let
                # extend the python package set with the two deps that are
                # not (yet) in nixpkgs-unstable
                python3Packages = uprev.python3.pkgs.overrideScope (
                  pyFinal: _pyPrev: {
                    # pdf-inspector is not yet in nixpkgs
                    pdf-inspector = pyFinal.callPackage
                      "${prTree}/pkgs/development/python-modules/pdf-inspector/default.nix"
                      { };
                    # zotero-mcp needs pyzotero >= 1.14.0; upstream pins
                    # uv_build<0.12.0 (nixpkgs-unstable now ships 0.12.5,
                    # which builds it fine), so relax the version pin
                    pyzotero =
                      (pyFinal.callPackage
                        "${prTree}/pkgs/development/python-modules/pyzotero/default.nix"
                        { }
                      ).overrideAttrs
                        (old: {
                          postPatch = (old.postPatch or "") + ''
                            substituteInPlace pyproject.toml \
                              --replace-fail "uv_build>=0.8.14,<0.12.0" "uv_build"
                          '';
                        });
                  }
                );
              in
              {
                inherit python3Packages;
                zotero-mcp = ufinal.callPackage
                  "${prTree}/pkgs/by-name/zo/zotero-mcp/package.nix"
                  { inherit python3Packages; };
              }
            )
          ];
        };
      })
    ];
  };

  flake.modules.homeManager.zotero-mcp =
    { pkgs, ... }:
    let
      # the optionals default to true upstream; override them here to flip
      # any off (e.g. withPdf = false) without touching the overlay
      pkg = pkgs.zotero-mcp-pkgs.zotero-mcp.override {
        withSemantic = true; # semantic search (chromadb, sentence-transformers, openai, google-genai, tiktoken)
        withPdf = true; # PDF layout analysis (pymupdf, ebooklib)
        withScite = true; # Scite citation data (requests)
      };
      py = pkgs.zotero-mcp-pkgs.python3;
      # the agent skill ships inside the package itself, so it is always
      # the exact same version as the installed CLI
      skillDir = "${pkg}/lib/python${py.pythonVersion}/site-packages/zotero_mcp/skills/zotero-cli";
    in
    {
      # provides the `zotero-cli` CLI (used by the zotero-cli skill)
      # plus the `zotero-mcp` server binary, should it ever be needed
      home.packages = [ pkg ];

      xdg.configFile."opencode/skills/zotero-cli".source = skillDir;
    };
}
