{
  flake.modules.homeManager.helix-gj1118 =
    {
      inputs,
      pkgs,
      config,
      lib,
      osConfig,
      name ? null,
      ...
    }:
    {

      home.packages = with pkgs; [
        nixd
      ];

      home.sessionVariables = {
        EDITOR = "hx";
        VISUAL = "hx";
        SUDO_EDITOR = "hx";
      };

      programs.helix = {
        enable = true;
        package = inputs.helix-gj1118.packages.${pkgs.stdenv.hostPlatform.system}.default;
        # package = pkgs.unstable.helix;
        defaultEditor = true;
        extraPackages = with pkgs; [
          # nixd is in global packages
        ];
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

      xdg.configFile = {
        "helix/config.toml".source = ./config.toml;
      };
    };
}
