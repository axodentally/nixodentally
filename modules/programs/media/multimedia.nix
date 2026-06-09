{
  flake.modules.homeManager.multimedia =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        plex-desktop
      ];
      services.flatpak.packages = [
        "com.github.wwmm.easyeffects"
        "org.pipewire.Helvum"
        "com.spotify.Client"
        "me.timschneeberger.GalaxyBudsClient"

      ];
    };
}
