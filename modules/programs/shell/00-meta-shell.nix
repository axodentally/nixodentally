{ inputs, ... }:
{
  flake.modules.homeManager.meta-shell = {
    imports = with inputs.self.modules.homeManager; [
      fish
      shell-utils
      git
      zellij
      yazi
    ];

  };
}
