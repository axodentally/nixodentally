{
  flake.modules.homeManager.network-rev-eng =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        httptoolkit
        burpsuite
        mitmproxy
      ];
    };
}
