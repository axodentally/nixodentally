{
  # flake.modules.homeManager.wireshark =
  #   { pkgs, ... }:
  #   {
  #     home.packages = with pkgs; [
  #       wireshark
  #     ];
  #   };
  flake.modules.nixos.wireshark =
    { pkgs, ... }:
    {
      programs.wireshark = {
        enable = true;
        package = pkgs.wireshark;
      };
    };
}
