{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        inriafonts
        vista-fonts
        corefonts
        excalifont # hand written
        fg-virgil
      ];
    };
}
