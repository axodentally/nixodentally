{
  lib,
  inputs,
  ...
}:
{
  flake.modules.nixos.amd = {
    boot.kernelParams = [
      "microcode.amd_sha_check=off"
    ];

    # enable microcode updates for AMD CPUs
    services.ucodenix = {
      enable = true;
      cpuModelId = lib.mkDefault "auto";
    };

    imports = [
      inputs.ucodenix.nixosModules.default
    ];

  };
}
