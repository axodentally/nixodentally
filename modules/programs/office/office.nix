{
  flake.modules.homeManager.office =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        onlyoffice-desktopeditors # better MS compatibility
        libreoffice-fresh # legacy crap
        hunspell
        hunspellDicts.en-us # dicts for libreoffice
        hunspellDicts.de_DE
        # libreoffice-collabora # modern libreoffice interface

        zotero

        nextcloud-client # nextcloud
        obsidian
        ffmpeg # used by obsidian Image Converter plugin

        unstable.presenterm

        gimp-with-plugins

        cryptomator

        gnome-frog # OCR screenshots
        dialect # translation
        diebahn # DB Navigator in cheap
      ];
      services.flatpak.packages = [
        # TODO: change to nixpkgs version
        "com.github.flxzt.rnote" # handwritten notes
        "com.github.jeromerobert.pdfarranger"
        "com.invoiceninja.InvoiceNinja" # invoices
      ];
    };
}
