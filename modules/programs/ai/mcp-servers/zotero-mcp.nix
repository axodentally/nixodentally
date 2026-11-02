{ inputs, ... }:
let
  # nixpkgs tree carrying the zotero-mcp packaging expressions
  # (github:NixOS/nixpkgs/pull/563759) until the PR is merged.
  # Only the three expressions (zotero-mcp, pdf-inspector, pyzotero) are
  # borrowed from it; every dependency is built from the pinned
  # nixpkgs-unstable package set, so this stays secure and updated.
  # TODO: remove this overlay and use pkgs.zotero-mcp directly
  # once the PR lands in nixos-unstable.
  prTree = inputs.nixpkgs-zotero-mcp;
in
{
  # zotero-mcp skill + CLI for opencode. Self-contained: the unstable
  # package set (with the zotero-mcp expressions from the PR tree) is
  # imported here directly, so this module works the same on NixOS-integrated
  # and standalone home configurations.
  flake.modules.homeManager.zotero-mcp =
    { lib, pkgs, ... }:
    let
      mcpPkgs = import inputs.nixpkgs-unstable {
        inherit (pkgs) config;
        system = pkgs.stdenv.hostPlatform.system;
        overlays = [
          (
            ufinal: uprev:
            let
              # extend the python package set with the two deps that are
              # not (yet) in nixpkgs-unstable
              python3Packages = uprev.python3.pkgs.overrideScope (
                pyFinal: pyPrev: {
                  # pdf-inspector is not yet in nixpkgs
                  pdf-inspector =
                    pyFinal.callPackage "${prTree}/pkgs/development/python-modules/pdf-inspector/default.nix"
                      { };
                  # zotero-mcp needs pyzotero >= 1.14.0
                  pyzotero = pyFinal.callPackage "${prTree}/pkgs/development/python-modules/pyzotero/default.nix" { };
                  # temporary: drop the (unused) posthog dependency from
                  # chromadb. Upstream removed it with chroma-core/chroma#6489,
                  # but nixpkgs-unstable still lists it, and posthog itself is
                  # currently broken there (NixOS/nixpkgs#578265), which blocks
                  # building chromadb (and thus zotero-mcp with semantic
                  # search). Remove this override once NixOS/nixpkgs#580508
                  # lands in nixos-unstable.
                  chromadb = pyPrev.chromadb.overridePythonAttrs (old: {
                    dependencies = lib.filter (d: d.pname or null != "posthog") old.dependencies;
                  });
                  # temporary: fastmcp — zotero-mcp's MCP framework — does not
                  # support mcp >= 2 yet, which nixpkgs-unstable now ships
                  # (marking fastmcp broken there). Use the in-tree mcp 1.x
                  # expression until a fastmcp release supporting mcp 2 lands
                  # in nixos-unstable.
                  mcp = pyPrev.mcp_1;
                }
              );
            in
            {
              inherit python3Packages;
              zotero-mcp = ufinal.callPackage "${prTree}/pkgs/by-name/zo/zotero-mcp/package.nix" {
                inherit python3Packages;
              };
            }
          )
        ];
      };
      # the optionals default to true upstream; override them here to flip
      # any off (e.g. withPdf = false) without touching the overlay
      pkg = mcpPkgs.zotero-mcp.override {
        withSemantic = true; # semantic search (chromadb, sentence-transformers, openai, google-genai, tiktoken)
        withPdf = true; # PDF layout analysis (pymupdf, ebooklib)
        withScite = true; # Scite citation data (requests)
      };
      py = mcpPkgs.python3;
      # the agent skill ships inside the package itself, so it is always
      # the exact same version as the installed CLI
      skillDir = "${pkg}/lib/python${py.pythonVersion}/site-packages/zotero_mcp/skills/zotero-cli";
    in
    {
      # provides the `zotero-cli` CLI (used by the zotero-cli skill)
      # plus the `zotero-mcp` server binary, should it ever be needed
      home.packages = [ pkg ];

      programs.opencode.skills.zotero-cli = skillDir;
    };
}
