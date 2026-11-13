{
  flake.modules.nixos.bitwarden = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      unstable.bitwarden-desktop
    ];
  };
}
