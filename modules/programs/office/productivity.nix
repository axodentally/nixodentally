{
  flake.modules.homeManager.productivity =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        planify # todo management
      ];
      services.flatpak.packages = [
        "io.github.mrvladus.List" # Gnome styled ToDos
        "com.super_productivity.SuperProductivity" # todo, time and project management
        "io.gitlab.idevecore.Pomodoro"
      ];

    };
}
