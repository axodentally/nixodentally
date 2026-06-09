{ inputs, ... }:
let
  name = "esaxo@axobuntu";
in
{
  flake.meta.hosts.${name}.primaryUser = "esaxo";
  flake.homeConfigurations = inputs.self.lib.mkHomeManager "x86_64-linux" name;

  flake.modules.homeManager.${name} =
    { config, lib, ... }:
    {
      imports = with inputs.self.modules.homeManager; [
        homemanager
        esaxo
        sops
        ssh-agent
        github-token

        bash-drop-to-fish
        truecolor-fix
        hm-for-sudo-fix

        meta-shell
        advanced-git-tools
        helix-gj1118
        direnv-devenv

        opencode
      ];

      config = {
        # since host is headless, a browser window cannot be opened locally
        programs.git-credential-oauth.extraFlags = [ "-device" ];

        # ssh private key and public key, also for git signing
        sops = {
          secrets = {
            "private_keys/esaxo" = {
              path = "${config.home.homeDirectory}/.ssh/esaxo-2026-25519";
              mode = "600";
            };
          };
        };
        home.file.".ssh/esaxo-2026-25519.pub".text = inputs.nix-secrets.pubkeys.esaxo;
        programs.git.settings.user.signingkey = "~/.ssh/esaxo-2026-25519.pub";

        nixpkgs.config.allowUnfree = true;
        home.stateVersion = "25.11";
        nixpkgs.overlays = [
          (final: _prev: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final) config;
              system = final.stdenv.hostPlatform.system;
            };
          })
        ];
      };
    };
}
