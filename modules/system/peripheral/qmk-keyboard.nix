{
  flake.modules.nixos.qmk-keyboard = {
    hardware.keyboard.qmk = {
      enable = true;
      keychronSupport = true;
    };
  };
}
