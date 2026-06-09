{
  inputs,
  ...
}:
{
  flake.modules.homeManager.git =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      programs = {
        git-credential-oauth.enable = true;

        git = {
          enable = true;
          signing = {
            format = "ssh";
            signByDefault = true;
          };
          settings = {
            user = {
              name = "${inputs.self.meta.users.${config.home.username}.gitUsername}";
              email = "${inputs.self.meta.users.${config.home.username}.gitEmail}";
              signingkey = lib.mkDefault "~/.ssh/id_ed25519.pub";
            };
            init.defaultBranch = "main";
            credential = {
              helper = lib.mkBefore [
                "${pkgs.git}/bin/git credential-cache --timeout ${toString (4 * 24 * 60 * 60)}"
              ];
              "https://github.com".helper = [
                ""
                "!${pkgs.gh}/bin/gh auth git-credential"
              ];
              "https://${inputs.nix-secrets.git-oauth.secrets-repo.domain}" = {
                oauthClientId = "${inputs.nix-secrets.git-oauth.secrets-repo.clientId}";
                oauthAuthURL = "/oauth/authorize";
                oauthTokenURL = "/oauth/token";
                oauthDeviceURL = "/oauth/authorize_device";
              };
              "https://${inputs.nix-secrets.git-oauth.esa-repo.domain}" = {
                oauthClientId = "${inputs.nix-secrets.git-oauth.esa-repo.clientId}";
                oauthAuthURL = "/oauth/authorize";
                oauthTokenURL = "/oauth/token";
                oauthDeviceURL = "/oauth/authorize_device";
              };
            };
          };

          # FIXME: should probably not be needed anymore, since I use oauth instead of libsecret now
          # in order to use gnome keyring to store git passwords, libsecret needs
          # to be built into git. Either by using gitFull or by using:
          # pkgs.git.override { withLibsecret = true; };
          package = pkgs.gitFull;
          lfs.enable = true;
        };
      };
    };
}
