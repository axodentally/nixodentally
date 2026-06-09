{
  flake.modules.homeManager.github-token =
    { config, pkgs, ... }:
    {
      nix = {
        package = pkgs.nix; # only so that HM assertion is satisfied. Actual nix is installed via Nix installer and of a different version, but should not matter
        extraOptions = ''
          !include ${config.sops.templates."nix-gh-access-token".path}
        '';
      };
      sops.templates."nix-gh-access-token".content = ''
        access-tokens = github.com=${config.sops.placeholder.github-access-token}
      '';
      sops.secrets.github-access-token = { };
    };
}
