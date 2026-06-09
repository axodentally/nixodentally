{ self, inputs, ... }:
let
  username = "esaxo";
  userMeta = {
    email = inputs.nix-secrets.esaxo.email;
    username = username;
    gitUsername = "axodentally";
    gitEmail = inputs.nix-secrets.esaxo.email;
  };
in
{
  flake.meta.users.${username} = userMeta;

  flake.modules.homeManager.${username} =
    { config, ... }:
    {
      home.username = username;
      home.homeDirectory = "/home/${username}";
    };
}
