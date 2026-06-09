{
  flake.modules.homeManager.room-eq-wizard =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        roomeqwizard # for room audio stuff
      ];
    };
}
