{ inputs, ... }:
{
  flake.modules.nixos.system-default = {
    imports = with inputs.self.modules.nixos; [
      locale
    ];

    nixpkgs.overlays = [
      (final: _prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final) config;
          system = final.stdenv.hostPlatform.system;
        };
      })
    ];

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
