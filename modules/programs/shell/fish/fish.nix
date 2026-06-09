{
  flake.modules.homeManager.fish =
    { pkgs, ... }:
    {
      xdg.configFile = {
        "fish/conf.d/00-home-manager-vars.fish" = {
          enable = true;
          source = ./config.fish;
        };
      };
      programs = {
        fish = {
          enable = true;
          interactiveShellInit = ''
            set fish_greeting # Disable greeting
            set fish_key_bindings fish_hybrid_key_bindings
            # Because the event functions are here, so we wanna load them all
            # Not the most efficient
            for f in $__fish_config_dir/functions/*
              source $f
            end
          '';
          plugins = [
            {
              name = "grc";
              src = pkgs.fishPlugins.grc.src;
            }
            {
              name = "autopair";
              src = pkgs.fishPlugins.autopair.src;
            }
            {
              name = "tide";
              src = pkgs.fishPlugins.tide.src;
            }
          ];
          functions = {
            fish_hybrid_key_bindings = {
              body = ''
                for mode in default insert visual
                    fish_default_key_bindings -M $mode
                end
                fish_vi_key_bindings --no-erase

              '';
              description = "Vi-style bindings that inherit emacs-style bindings in all modes";
            };
            y = {
              body = ''
                set tmp (mktemp -t "yazi-cwd.XXXXXX")
                yazi $argv --cwd-file="$tmp"
                if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
                  builtin cd -- "$cwd"
                end
                rm -f -- "$tmp"
              '';
              description = "Function for changing directory using yazi";
            };
          };
          shellAliases = {
            "ls" = "eza --group-directories-first --icons";
            "ll" = "eza -lg --git --icons --octal-permissions --group-directories-first";
            "la" = "eza -lga --git --icons --octal-permissions --group-directories-first";
            "lt" = "eza --tree --level=2";
            "cp" = "cp -v";
            "sl" = "ls";
            "ip" = "ip -c";
            "del" = "trash-put";
            "netcat" = "nc";
            "ncat" = "nc";
          };
        };
      };

    };
}
