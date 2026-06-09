{
  flake.modules.nixos.bluetooth = {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          # Shows battery charge of connected devices on supported
          # Bluetooth adapters. Defaults to 'false'.
          Experimental = true;
        };
      };
    };
  };
}
