{ inputs, ... }:
let
  hostname = "milenpa";
  primaryUser = "axo";
in
{
  flake.meta.hosts.${hostname}.${primaryUser} = "axo";

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "${hostname}";
  flake.modules.nixos.${hostname} =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports =
        with inputs.self.modules.nixos;
        [
          # system-type
          system-default
          disko
          # system-desktop

          ssh-server
          zswap
          sops

          # users
          axo

          # home manager
          homemanager

          ./_disko-data.nix
        ]
        ++ [
          {
            home-manager.users.axo = {
              imports = with inputs.self.modules.homeManager; [
                # system-type
                #         system-desktop

                # users
                axo

                #         # home manager
                homemanager

                #         # programs
                #         three-d-printing
                #         chrome
                #         firefox
                #         ungoogled-chromium
                #         communication
                #         gnome
                #         audacity
                #         # kdenlive
                #         multimedia
                #         # room-eq-wizard
                #         monitoring
                #         office
                #         galaxy-buds
                #         productivity
                #         rustdesk-client
                #         # android-rev-eng
                #         # jadx-mcp-server
                #         # network-rev-eng
                meta-shell # meta package
                helix
                #         kitty
                #         ghostty
                #         # AI stuff
                #         opencode
                #         zed-editor
                #         mcp-nixos
              ];
              config = {
                home.stateVersion = "26.05";
                # TODO: make that nicer, so that default key is auto-discovered for every host
                programs.git.settings.user.signingkey = "~/.ssh/axodentally-milenpa-2026-25519.pub";
              };
            };
          }
        ];

      config = {
        sops = {
          secrets = {
            "private_keys/axo" = {
              path = "/home/axo/.ssh/axodentally-milenpa-2026-25519";
              mode = "600";
              owner = "axo";
              group = "users";
            };
          };
        };

        networking.useDHCP = true;
        nix.settings.auto-optimise-store = true;

        boot = {
          loader = {
            efi.canTouchEfiVariables = true;

            systemd-boot.enable = false;

            limine = {
              enable = true;

              # Leave this off for the first installation/boot.
              # Enable and enroll keys only after boot is confirmed.
              secureBoot.enable = false;
            };
          };

          initrd.systemd = {
            # Needed later for TPM2-backed LUKS unlocking.
            tpm2.enable = true;
          };
        };

        security.tpm2 = {
          enable = true;
          tctiEnvironment.enable = true;
        };

        users.users.${primaryUser}.openssh.authorizedKeys.keys = [
          inputs.nix-secrets.pubkeys.chalco
        ];

        environment.systemPackages = with pkgs; [
          git
          vim
          btrfs-progs
          cryptsetup
          sbctl
          tpm2-tools
        ];

        services.fstrim.enable = true;

        system.stateVersion = "26.05";
        # fwupd.enableTestingRemotes = true;
        networking.hostName = "${hostname}";
        # services.ucodenix.cpuModelId = "00A70F41";
      };
    };
}
