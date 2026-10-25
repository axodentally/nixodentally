{ inputs, ... }:
{
  flake.modules.homeManager.nix-skills = {
    imports = [
      inputs.nix-skills.homeManagerModules.default
    ];

    programs.nix-skills = {
      enable = true;
      agents = [ "opencode" ];
    };
  };
}
