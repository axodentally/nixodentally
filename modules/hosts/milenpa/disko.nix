{ ... }:

let
  disk = "/dev/disk/by-id/nvme-KIOXIA-EXCERIA_PLUS_G3_SSD_5FSKF154Z0EA";
  swapSize = "16G";
in
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = disk;

      content = {
        type = "gpt";

        partitions = {
          ESP = {
            name = "ESP";
            size = "1G";
            type = "EF00";

            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          luks = {
            name = "luks-cryptroot";
            size = "100%";

            content = {
              name = "cryptroot";
              type = "luks";

              # Do not put a password/key file in the Nix store.
              # With no keyFile/passwordFile configured, Disko prompts
              # interactively while it creates the LUKS container.
              settings = {
                allowDiscards = true;

                # This is consumed by systemd-cryptsetup in the initrd
                # after you enroll the TPM token below.
                crypttabExtraOpts = [
                  "tpm2-device=auto"
                ];
              };

              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "-L"
                  "nixos"
                ];

                subvolumes = {
                  "/@root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                    ];
                  };

                  "/@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                    ];
                  };

                  "/@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                    ];
                  };

                  "/@var-lib" = {
                    mountpoint = "/var/lib";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                    ];
                  };

                  "/@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                    ];
                  };

                  "/@srv" = {
                    mountpoint = "/srv";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                    ];
                  };

                  "/@snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = [
                      "compress=zstd:3"
                      "noatime"
                    ];
                  };

                  "/@swap" = {
                    mountpoint = "/.swapvol";

                    # Disko creates a Btrfs-appropriate swapfile.
                    # Do not create an ordinary CoW/compressed file yourself.
                    swap.swapfile.size = swapSize;
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
