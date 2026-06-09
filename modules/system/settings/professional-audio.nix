{ inputs, ... }:
{
  flake.modules.nixos.professional-audio = {
    imports = [
      inputs.musnix.nixosModules.musnix
    ];
    musnix.enable = true;

    services.pipewire = {
      # maybe needed for audacity..? can maybe also be removed
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
