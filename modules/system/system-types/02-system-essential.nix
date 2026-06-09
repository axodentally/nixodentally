{ inputs, ... }:
{
  flake.modules.nixos.system-essential = {
    imports = with inputs.self.modules.nixos; [
      # system-type
      system-default

      # system settings
      systemd-boot
    ];

  };
}
