{
  flake.modules.nixos.linux-latest =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };

}
