{ ... }:
let
  disk1 = "/dev/disk/by-id/ata-TOSHIBA_MG09ACA18TE_7440A02NFJDH";
  disk2 = "/dev/disk/by-id/ata-TOSHIBA_MG09ACA18TE_7470A02QFJDH";
in
{
  disko.devices.disk = {
    disk1 = {
      type = "disk";
      device = disk1;

      content = {
        type = "gpt";

        partitions.data = {
          name = "data1-luks";
          size = "100%";

          content = {
            type = "luks";
            name = "data1";
            initrdUnlock = false;

            settings.keyFile = "/var/lib/luks-keys/data1.key";

            # No filesystem here: this is the first mirror member.
          };
        };
      };
    };

    disk2 = {
      type = "disk";
      device = disk2;

      content = {
        type = "gpt";

        partitions.data = {
          name = "data2-luks";
          size = "100%";

          content = {
            type = "luks";
            name = "data2";
            initrdUnlock = false;

            settings.keyFile = "/var/lib/luks-keys/data2.key";

            content = {
              type = "btrfs";

              # Disko supplies /dev/mapper/data2 automatically.
              # Supply data1 as the additional member.
              extraArgs = [
                "-L storage"
                "-d raid1"
                "-m raid1"
                "/dev/mapper/data1"
              ];

              subvolumes = {
                "/@data" = {
                  mountpoint = "/srv/storage";

                  mountOptions = [
                    "compress=zstd:3"
                    "noatime"
                    "device=/dev/mapper/data1"
                    "x-systemd.requires=systemd-cryptsetup@data1.service"
                    "x-systemd.requires=systemd-cryptsetup@data2.service"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
