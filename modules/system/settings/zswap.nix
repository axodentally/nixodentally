{
  flake.modules.nixos.zswap = {
    boot = {
      zswap = {
        enable = true;
        compressor = "lz4";
        maxPoolPercent = 20;
      };
    };
  };
}
