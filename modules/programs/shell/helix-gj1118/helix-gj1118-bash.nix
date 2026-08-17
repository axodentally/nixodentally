{
  flake.modules.homeManager.helix-gj1118 =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = with pkgs; [
          bash-language-server
        ];
      };
    };
}
