{
  flake.modules.homeManager.three-d-printing =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        orca-slicer # 3d printing

        # freecad-wayland
        # dune3d
      ];
    };
}
