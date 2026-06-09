{ inputs, ... }:
let
  sopsFolder = toString inputs.nix-secrets + "/sops";
in
{
  flake.modules.nixos.sops =
    { pkgs, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      environment.systemPackages = with pkgs; [
        sops
        age
        ssh-to-age
      ];

      sops = {
        defaultSopsFile = "${sopsFolder}/secrets.yaml";

        age = {
          sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
          keyFile = "/var/lib/sops-nix/key.txt";
          generateKey = true;
        };

        secrets = {
          sample_password = { };
        };
      };
    };

  flake.modules.homeManager.sops =
    { pkgs, config, ... }:
    {
      imports = [
        inputs.sops-nix.homeManagerModules.sops
      ];

      sops = {
        defaultSopsFile = "${sopsFolder}/${config.home.username}.yaml";
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };
}
