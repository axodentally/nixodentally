{
  flake.modules.nixos.laptop-powersaving = {
    boot.kernelParams = [
      "pcie_aspm=force"
    ];

    networking.networkmanager.wifi.powersave = false;

    powerManagement.powertop.enable = false;
  };

}
