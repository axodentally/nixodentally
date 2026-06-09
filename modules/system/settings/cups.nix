{
  flake.modules.nixos.cups =
    { pkgs, ... }:
    {
      # Enable CUPS to print documents.
      services.printing.enable = true;

      # enable apple print / IPP everywhere and autodiscover network printers
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        nssmdns6 = true;
        openFirewall = true;
      };

      # hp printing driver
      # possibliy not even needed, since IPP everywhere printing should
      # work without additional drivers...
      services.printing.drivers = [ pkgs.hplip ];
    };
}
