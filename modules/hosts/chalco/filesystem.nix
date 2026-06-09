{
  flake.modules.nixos.chalco =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/54f35b16-1c8d-43a4-868e-76ff9ee88db5";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };

      boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/5d8fa9f3-e936-4b7c-8ce7-52d12850cd1f";

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/18F0-77BB";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      swapDevices = [ ];
      zramSwap.enable = true;

      services.btrfs.autoScrub.enable = true;
    };
}
