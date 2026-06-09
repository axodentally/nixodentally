{
  flake.modules.homeManager.hm-for-sudo-fix = {
    programs.fish.shellAliases = {
      sudo = "sudo --preserve-env=PATH -E env";
    };
  };
}
