{
  flake.modules.homeManager.rustdesk-client =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        rustdesk-flutter
      ];
    };
}
