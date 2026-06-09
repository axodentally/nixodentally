{ self, inputs, ... }:
let
  username = "axo";
  userMeta = {
    email = inputs.nix-secrets.email.user;
    name = inputs.nix-secrets.userFullName;
    username = username;
    gitUsername = "axodentally";
    gitEmail = inputs.nix-secrets.email.github;
  };
in
{
  flake.meta.users.${username} = userMeta;

  flake.modules.nixos.${username} =
    { config, ... }:
    {
      sops.secrets.axo-password.neededForUsers = true;

      users.users.${username} = {
        description = username;
        isNormalUser = true;
        createHome = true;
        hashedPasswordFile = config.sops.secrets.axo-password.path;
        extraGroups = [
          # TODO: check if those are neccessary. Also move to other modules
          "audio"
          "dialout"
          "networkmanager"
          "wheel"
          "wireshark"
          "adbusers" # needed?
        ];
      };
    };
  flake.modules.homeManager.${username} =
    { config, ... }:
    {
      home.username = username;
      home.homeDirectory = "/home/${username}";
    };
}
