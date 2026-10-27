{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # private repo providing sops encrypted secrets
    nix-secrets = {
      # url = "git+https://chaos.expert/axo/nix-secrets.git?ref=main&shallow=1";
      url = "git+ssh://git@codeberg.org/axoaxo/nix-secrets.git?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # enable microcode updates for AMD CPUs without needing
    # to rely on BIOS updates
    ucodenix.url = "github:e-tho/ucodenix";

    # declarative flatpak applications
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # slightly unstable helix fork, with slightly too many PRs merged from upstream
    # but providing more features
    helix-gj1118.url = "github:gj1118/helix";

    autoaspm = {
      url = "git+https://git.notthebe.ee/notthebee/AutoASPM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # jadx-mcp-server.url = "path:./flakes/jadx-mcp-server";

    # snap support
    # nix-snapd.url = "github:nix-community/nix-snapd";
    # nix-snapd.inputs.nixpkgs.follows = "nixpkgs";

    # musnix = {
    #   url = "github:musnix/musnix";
    #   # maybe letting it follow nixpkgs-unstable is better, since upstream
    #   # follows unstable. Not sure
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # temporary: nixpkgs tree carrying the zotero-mcp packaging expressions
    # (github:NixOS/nixpkgs/pull/563759) until the PR is merged into unstable.
    # Only the three .nix expressions are used; all dependencies are built
    # from the pinned nixpkgs-unstable package set. Remove once merged.
    nixpkgs-zotero-mcp = {
      # pinned to the current PR head commit; the branch gets force-pushed
      url = "github:t4ccer/nixpkgs/c82a7c6978183c8cfe9e1636533b92634bf885ca";
      flake = false; # we only want the .nix files, not its package set
    };

    nix-skills = {
      url = "github:olafkfreund/nix-skills";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
