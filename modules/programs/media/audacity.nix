{
  flake.modules.homeManager.audacity =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        audacity
        x42-plugins
      ];
    };
}
