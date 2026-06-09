{
  flake.modules.homeManager.android-rev-eng =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        android-studio
        android-tools
        frida-tools
        apktool
        unstable.jadx
      ];
    };
}
