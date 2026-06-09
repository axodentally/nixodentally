{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";

    # nixpkgs-ansible-lsp110 = {
    #   url = "github:NixOS/nixpkgs/50511e0a272f7f3ddc80277601b8f5c70615cb70";
    # };
    # nixpkgs-mesa-good.url = "github:nixos/nixpkgs?ref=599ddd2b79331c1e6153e1659bdaab65d62c4c82";
    # nixpkgs-davinci-resolve.url = "github:NixOS/nixpkgs?ref=pull/370719/head";
    # nixpkgs-pr-436966.url = "github:NixOS/nixpkgs?ref=pull/436966/head";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # private repo providing sops encrypted secrets
    nix-secrets = {
      url = "git+https://chaos.expert/axo/nix-secrets.git?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # enable microcode updates for AMD CPUs without needing
    # to rely on BIOS updates
    ucodenix.url = "github:e-tho/ucodenix";
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
    # jadx-mcp-server = {
    #   url = "path:./flakes/jadx-mcp-server";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    helix-gj1118.url = "github:gj1118/helix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
