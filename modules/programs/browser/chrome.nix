{
  flake.modules.homeManager.chrome = {
    services.flatpak.packages = [
      "com.google.Chrome"
    ];
  };
}
