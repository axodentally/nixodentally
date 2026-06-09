{ inputs, ... }:
{
  flake.modules.nixos.qemu =
    {
      config,
      pkgs,
      ...
    }:
    let
      primaryUser = inputs.self.meta.hosts.${config.networking.hostName}.primaryUser;
    in
    {
      virtualisation.libvirtd = {
        enable = true;

        # Enable TPM emulation (for Windows 11)
        qemu = {
          swtpm.enable = true;
        };
      };

      # Enable USB redirection
      virtualisation.spiceUSBRedirection.enable = true;

      # Allow VM management
      users.users.${primaryUser}.extraGroups = [
        "libvirtd"
        "kvm"
        "vboxusers"
      ];

      # Enable VM networking and file sharing
      environment.systemPackages = with pkgs; [
        gnome-boxes # VM management
        dnsmasq # VM networking
        phodav # (optional) Share files with guest VMs
        quickemu # Quickly create and run optimised Windows, macOS and Linux virtual machines
      ];

      services.spice-vdagentd.enable = true; # enable clipboard sharing
      systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];

      programs.virt-manager.enable = true;

      # virtualisation.virtualbox.host.enable = true;
      # virtualisation.virtualbox.host.enableExtensionPack = true;

    };
}
