{
  flake.modules.homeManager.galaxy-buds =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        earbuds
      ];
    };
}
