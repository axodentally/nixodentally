{
  flake.modules.nixos.fwupd =
    { lib, config, ... }:
    {
      options = {
        fwupd.enableTestingRemotes = lib.mkEnableOption {
          description = "Enable lvfs-testing remote. May include buggy firmware!";
          default = false;
        };
      };
      config = {
        services.fwupd = {
          enable = true;
          extraRemotes = lib.mkIf (config.fwupd.enableTestingRemotes) [
            "lvfs-testing"
          ];
        };
      };
    };
}
