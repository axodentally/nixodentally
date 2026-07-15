{
  flake.modules.homeManager.devenv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        unstable.devenv
      ];
    };
}
