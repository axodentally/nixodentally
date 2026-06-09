{
  flake.modules.homeManager.helix =
    {
      pkgs,
      config,
      lib,
      osConfig,
      name ? null,
      ...
    }:
    {

      home.packages = with pkgs; [
        # see https://yazi-rs.github.io/docs/tips/#helix-with-zellij
        (writeShellScriptBin "yazi-picker" ''
          paths=$(yazi "$2" --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)

          if [[ -n "$paths" ]]; then
          	zellij action toggle-floating-panes
          	zellij action write 27 # send <Escape> key
          	zellij action write-chars ":$1 $paths"
          	zellij action write 13 # send <Enter> key
          else
          	zellij action toggle-floating-panes
          fi
        '')

        nixd
      ];

      home.sessionVariables = {
        EDITOR = "hx";
        SUDO_EDITOR = "hx";
      };

      programs.helix = {
        enable = true;
        package = pkgs.unstable.helix;
        defaultEditor = true;
        extraPackages = with pkgs; [
          # nixd is in global packages
        ];
        settings = {
          theme = "papercolor-light";
          editor = {
            cursor-shape.insert = "bar";
            bufferline = "always";
            color-modes = true;
            rulers = [ 80 ];
            soft-wrap.enable = true;
            statusline = {
              left = [
                "mode"
                "file-name"
                "version-control"
                "read-only-indicator"
                "file-modification-indicator"
              ];
              right = [
                "spinner"
                "diagnostics"
                "file-type"
                "file-encoding"
                "selections"
                "register"
                "position"
              ];
              mode.normal = "NORMAL";
              mode.insert = "INSERT";
              mode.select = "SELECT";
            };
            lsp = {
              display-inlay-hints = true;
              display-messages = true;
            };
          };
          keys = {
            normal = {
              space.o = "file_picker_in_current_buffer_directory";
              C-l = [
                ":new"
                ":insert-output lazygit"
                ":buffer-close!"
                ":redraw"
              ];
              C-y = {
                y = '':sh zellij run -n "" -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- yazi-picker open %{buffer_name}'';
                # Open the file(s) in a vertical split
                v = '':sh zellij run -n "" -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- yazi-picker vsplit %{buffer_name}'';
                # Open the file(s) in a horizontal split
                h = '':sh zellij run -n "" -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- yazi-picker hsplit %{buffer_name}'';
              };
              # already included in helix-typst.nix
              # for Typst, not optimal but a way.
              # C-p = [ ":sh typst watch ./*.typ & zathura ./*.pdf" ];
            };
          };
        };
        languages = {
          language = [
            {
              name = "nix";
              auto-format = true;
              language-servers = [ "nixd" ];
            }
          ];
          language-server = {
            nixd = {
              command = "nixd";
              args = [ "--semantic-tokens=true" ];
              config.nixd =
                let
                  # Get path of the system flake via nh
                  myFlake = ''(builtins.getFlake "${config.programs.nh.flake}")'';
                  isNixOS = osConfig != null;

                  # get nixos options if host is nixos
                  nixosOpts =
                    if isNixOS then "${myFlake}.nixosConfigurations.${osConfig.networking.hostName}.options" else "";

                  # get home manager options
                  hmOpts =
                    if isNixOS then
                      "${nixosOpts}.home-manager.users.type.getSubOptions []"
                    else
                      "${myFlake}.homeConfigurations.\"${name}\".options";
                in
                {
                  nixpkgs.expr = "import ${myFlake}.inputs.nixpkgs { }";
                  formatting.command = [ "${lib.getExe pkgs.nixfmt-rfc-style}" ];
                  options =
                    (lib.optionalAttrs isNixOS {
                      nixos.expr = nixosOpts;
                    })
                    // {
                      home-manager.expr = hmOpts;
                    };
                };
            };
          };
        };
      };
    };
}
