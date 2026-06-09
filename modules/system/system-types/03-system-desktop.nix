{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-essential

      cups
      fwupd
      location-services
      networkmanager
      pipewire-airplay
      bluetooth
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      flatpak
    ];
  };
}
