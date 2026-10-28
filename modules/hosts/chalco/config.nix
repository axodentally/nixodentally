{ inputs, ... }:
let
  hostname = "chalco";
in
{
  flake.meta.hosts.${hostname}.primaryUser = "axo";

  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "${hostname}";
  flake.modules.nixos.${hostname} =
    { config, lib, ... }:
    {
      imports =
        with inputs.self.modules.nixos;
        [
          # system-type
          system-desktop

          sops

          # system settings
          amd
          laptop-powersaving
          autoaspm
          linux-latest
          flatpak # TODO: check if correctly defined in the module!
          key-remapping

          # peripherals
          logitech
          qmk-keyboard
          fingerprint

          # users
          axo

          # virtualisation
          qemu
          podman

          # home manager
          homemanager

          # programs
          firefox
          gnome
          fonts
          wireshark
        ]
        ++ [
          {
            home-manager.users.axo = {
              imports = with inputs.self.modules.homeManager; [
                # system-type
                system-desktop

                # users
                axo

                # home manager
                homemanager

                # programs
                three-d-printing
                chrome
                firefox
                ungoogled-chromium
                communication
                gnome
                audacity
                # kdenlive
                multimedia
                room-eq-wizard
                monitoring
                office
                galaxy-buds
                productivity
                rustdesk-client
                # network-rev-eng
                meta-shell # meta package
                helix
                kitty
                ghostty
                # AI stuff
                meta-ai # opencode + mcp-nixos + nix-skills (+ aichat, commented out)
                meta-ai-literature # zotlit + zotero-mcp + read-pdf skill
              ];
              config = {
                home.stateVersion = "23.11";
                custom.git.credentialBackend = "libsecret";
              };
            };
          }
        ];

      config = {
        sops = {
          secrets = {
            "private_keys/axo" = {
              path = "/home/axo/.ssh/axodentally-2026-25519";
              mode = "600";
              owner = "axo";
              group = "users";
            };
          };
        };

        boot.loader.systemd-boot.configurationLimit = 4;

        system.stateVersion = "23.11";
        fwupd.enableTestingRemotes = true;
        networking.hostName = "${hostname}";
        services.ucodenix.cpuModelId = "00A70F41";
      };
    };
}
