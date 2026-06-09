{ inputs, ... }:
{
  flake.modules.nixos.logitech =
    { config, ... }:
    let
      primaryUser = inputs.self.meta.hosts.${config.networking.hostName}.primaryUser;
    in
    {
      # enable logitech configuration via ltunify and solaar
      hardware.logitech.wireless.enable = true;
      hardware.logitech.wireless.enableGraphical = true;

      # also something for logitech stuff, though not sure what
      # and also not if it even does anything / is needed
      hardware.uinput.enable = true;

      users.users.${primaryUser}.extraGroups = [ "uinput" ];
    };

}
