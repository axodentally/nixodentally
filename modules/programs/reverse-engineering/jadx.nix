{
  flake.modules.homeManager.jadx =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        unstable.jadx
      ];
      # services.flatpak.packages = [
      #   "com.github.skylot.jadx"
      # ];
      # services.flatpak.overrides = {
      #   "com.github.skylot.jadx".Environment = {
      #     _JAVA_AWT_WM_NONPARENTING = "1";
      #     GDK_SCALE = "2";
      #   };
      # };
    };
}
