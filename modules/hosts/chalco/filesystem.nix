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
        options = [
          "subvol=@"
          "compress=zstd"
          "noatime"
        ];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/54f35b16-1c8d-43a4-868e-76ff9ee88db5";
        fsType = "btrfs";
        options = [
          "subvol=@home"
          "compress=zstd"
          "noatime"
        ];
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/54f35b16-1c8d-43a4-868e-76ff9ee88db5";
        fsType = "btrfs";
        options = [
          "subvol=@nix"
          "compress=zstd"
          "noatime"
        ];
      };

      fileSystems."/var/lib" = {
        device = "/dev/disk/by-uuid/54f35b16-1c8d-43a4-868e-76ff9ee88db5";
        fsType = "btrfs";
        options = [
          "subvol=@var-lib"
          "compress=zstd"
          "noatime"
        ];
      };

      fileSystems."/var/log" = {
        device = "/dev/disk/by-uuid/54f35b16-1c8d-43a4-868e-76ff9ee88db5";
        fsType = "btrfs";
        options = [
          "subvol=@log"
          "compress=zstd"
          "noatime"
        ];
      };

      fileSystems."/.snapshots" = {
        device = "/dev/disk/by-uuid/54f35b16-1c8d-43a4-868e-76ff9ee88db5";
        fsType = "btrfs";
        options = [
          "subvol=@snapshots"
          "compress=zstd"
          "noatime"
        ];
      };

      boot.initrd.luks.devices."enc" = {
        device = "/dev/disk/by-uuid/5d8fa9f3-e936-4b7c-8ce7-52d12850cd1f";
        allowDiscards = true;
        bypassWorkqueues = true;
      };

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
