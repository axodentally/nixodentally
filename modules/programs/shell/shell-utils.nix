{
  flake.modules.homeManager.shell-utils =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        # advanced core utils etc
        trash-cli # safer rm
        grc # colours - though probably unmaintained!
        fzf # fuzzy find
        zoxide # z, autojump etc like
        eza # A modern replacement for ‘ls’
        dysk # modern df replacement
        caligula # TUI for disk imaging, as more user friendly dd alternative

        fastfetch

        # compression
        ouch # CLI tool for compressing and decompressing various formats
        zip
        xz
        unzip
        p7zip

        ripgrep # recursively searches directories for a regex pattern

        # networking tools
        wget
        curl
        dnsutils # `dig` + `nslookup`
        ldns # replacement of `dig`, it provide the command `drill`
        aria2 # A lightweight multi-protocol & multi-source command-line download utility
        nmap # A utility for network discovery and security auditing
        ipcalc # it is a calculator for the IPv4/v6 addresses

        # misc
        file
        mediainfo
        which
        tree
        gnused
        gnutar
        gawk
        zstd
        gnupg

        nix-output-monitor # provides the command `nom`. works just like `nix` with more details log output

        # tops
        btop-rocm # replacement of htop/nmon
        amdgpu_top # further amd gpu monitoring
        iotop # io monitoring
        iftop # network monitoring

        # productivity
        glow # markdown previewer in terminal

        # system call monitoring
        lsof # list open files

        # system tools
        lm_sensors # for `sensors` command
        ethtool
        pciutils # lspci
        usbutils # lsusb

        wl-clipboard

      ];

      programs = {
        gh = {
          enable = true;
          settings = {
            git_protocol = "ssh";
          };
          gitCredentialHelper.enable = false;
        };
        bat = {
          enable = true;
          extraPackages = with pkgs.bat-extras; [
            batgrep
            batwatch
            prettybat
          ];
          config = {
            style = "plain";
          };
        };
        nh = {
          enable = true;
          clean.enable = true;
          clean.extraArgs = "--keep-since 14d --keep 5";
          flake = "/home/${config.home.username}/src/nix";
        };
        lazygit = {
          enable = true;
          enableFishIntegration = true;
          settings = {
            gui = {
              nerdFontsVersion = "3";
            };
            git = {
              overrideGpg = true;
            };
          };
        };
      };
    };
}
