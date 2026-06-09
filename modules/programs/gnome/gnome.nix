{
  flake.modules.nixos.gnome =
    { pkgs, ... }:
    {
      services = {
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };

      # enable gs connect via options (automatically creates firewall rules etc)
      programs.kdeconnect = {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };

      environment.sessionVariables.QT_QPA_PLATFORM = "wayland;xcb";

      # https://github.com/NixOS/nixpkgs/issues/149812
      environment.extraInit = ''
        export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      '';
    };

  flake.modules.homeManager.gnome =
    { pkgs, ... }:
    {
      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
            two-finger-scrolling-enabled = true;
            edge-scrolling-enabled = false;
          };
          "org/gnome/desktop/interface" = {
            gtk-theme = "adw-gtk3";
          };
          # enable fractional scaling
          # has to be set in the GUI afterwards and it gets saved to ~/.config/monitors.xml (see below)
          # though home.file does not seem to work like it should
          # further links:
          # https://github.com/NixOS/nixpkgs/pull/107850
          # https://discourse.nixos.org/t/gdm-monitor-configuration/6356/4
          "org/gnome/mutter" = {
            edge-tiling = true;
            experimental-features = [
              "scale-monitor-framebuffer"
              "xwayland-native-scaling"
              "variable-refresh-rate"
              "autoclose-xwayland"
            ];
          };
          "org/gnome/shell" = {
            "app-switcher/current-workspace-only" = true;
            disable-user-extensions = false;

            # `gnome-extensions list` for a list
            enabled-extensions = [
              "light-style@gnome-shell-extensions.gcampax.github.com" # proper light theme
              "appindicatorsupport@rgcjonas.gmail.com"
              "nightthemeswitcher@romainvigier.fr"
              "legacyschemeautoswitcher@joshimukul29.gmail.com"
              "blur-my-shell@aunetx"
              "caffeine@patapon.info"
              "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
              "gsconnect@andyholmes.github.io"
              # "hass-gshell@geoph9-on-github"
              # "marcs14@gmail.com" # power tracker
              "tiling-assistant@leleat-on-github"
              "clipboard-indicator@tudmotu.com" # clipboard manager
              "batterytimepercentagecompact@sagrland.de" # battery time estimation
              "auto-power-profile@dmy3k.github.io" # auto power profile switcher
              "Vitals@CoreCoding.com" # system stats
            ];
          };
          # make light shell work with blur-my-shell
          "org/gnome/shell/extensions/blur-my-shell/panel" = {
            force-light-text = true;
          };
          "org/gnome/Console" = {
            shell = "['/etc/profiles/per-user/axo/bin/fish']";
          };
          # move thunderbird and signal to workspace 2
          "org/gnome/shell/extensions/auto-move-windows" = {
            application-list = [
              "thunderbird.desktop:2"
              "signal-desktop.desktop:2"
            ];
          };
        };
      };

      home.packages = with pkgs; [
        gnomeExtensions.light-style
        gnomeExtensions.appindicator
        gnomeExtensions.night-theme-switcher
        gnomeExtensions.legacy-gtk3-theme-scheme-auto-switcher
        gnomeExtensions.blur-my-shell
        gnomeExtensions.caffeine
        gnomeExtensions.home-assistant-extension
        gnomeExtensions.power-tracker
        gnomeExtensions.tiling-assistant
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.battery-time-percentage-compact
        gnomeExtensions.auto-power-profile
        gnomeExtensions.vitals
        gnome-extension-manager
        adw-gtk3
        gnome-tweaks
      ];

    };
}
