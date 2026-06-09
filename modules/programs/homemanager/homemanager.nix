{ inputs, ... }:
{
  flake.modules.homeManager.homemanager = {
    programs.home-manager.enable = true;
  };

  flake.modules.nixos.homemanager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
      }
    ];
  };
}
