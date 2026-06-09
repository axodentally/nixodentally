{
  flake.modules.homeManager.communication =
    { pkgs, ... }:
    {
      services.flatpak.packages = [
        "org.gnome.Fractal" # Matrix client
        "com.discordapp.Discord"
        "hu.irl.cameractrls" # Cameractrls
      ];

      home.packages = with pkgs; [
        signal-desktop
        thunderbird

        # discord
        # webcord
        # vesktop
      ];
    };
}
