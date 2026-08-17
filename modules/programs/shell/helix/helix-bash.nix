{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          bash-language-server
        ];
      };
    };
}
