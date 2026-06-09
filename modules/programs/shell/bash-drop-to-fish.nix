{
  flake.modules.homeManager.bash-drop-to-fish = {
    programs.bash = {
      enable = true;
      initExtra = ''
        if shopt -q login_shell; then
          if [[ $EUID -ne 0 && -x ~/.nix-profile/bin/fish && -t 1 ]]; then
            exec ~/.nix-profile/bin/fish
          fi
        fi
      '';
    };
  };
}
