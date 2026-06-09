{
  flake.modules.homeManager.monitoring =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gnome-power-manager
      ];
    };
}
