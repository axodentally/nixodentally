{
  flake.modules.homeManager.openjdk21 = { pkgs, ... }: {

    home.packages = with pkgs; [
      openjdk21
      maven
    ];
  };
}
