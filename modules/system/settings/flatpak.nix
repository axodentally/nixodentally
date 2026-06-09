{ inputs, ... }:
{
  flake.modules.nixos.flatpak = {
    services.flatpak.enable = true;
  };
  flake.modules.homeManager.flatpak = {
    imports = [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ];
    # nix-flatpak setup
    services.flatpak = {
      enable = true;
      update.auto = {
        enable = true;
        onCalendar = "daily";
      };
      uninstallUnmanaged = false;
    };
  };

}
