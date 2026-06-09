{
  flake.modules.homeManager.ungoogled-chromium = {
    services.flatpak.packages = [
      "io.github.ungoogled_software.ungoogled_chromium"
    ];
  };
}
