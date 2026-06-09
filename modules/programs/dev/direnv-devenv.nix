{
  flake.modules.homeManager.direnv-devenv =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        unstable.devenv
      ];
      programs.direnv = {
        enable = true;
      };
    };
}
