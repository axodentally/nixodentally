{
  flake.modules.homeManager.yazi =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        enableFishIntegration = true;

        plugins = {
          inherit (pkgs.yaziPlugins)
            ouch
            mediainfo
            git
            ;
        };
        initLua = ''
          require("git"):setup()
        '';
        # this shit does not work! grrrr
        settings = {
          log = {
            enabled = false;
          };
          plugin = {
            prepend_previewers = [
              {
                mime = "application/*zip";
                run = "ouch";
              }
              {
                mime = "application/x-tar";
                run = "ouch";
              }
              {
                mime = "application/x-bzip2";
                run = "ouch";
              }
              {
                mime = "application/x-7z-compressed";
                run = "ouch";
              }
              {
                mime = "application/x-rar";
                run = "ouch";
              }
              {
                mime = "application/vnd.rar";
                run = "ouch";
              }
              {
                mime = "application/x-xz";
                run = "ouch";
              }
              {
                mime = "application/xz";
                run = "ouch";
              }
              {
                mime = "application/x-zstd";
                run = "ouch";
              }
              {
                mime = "application/zstd";
                run = "ouch";
              }
              {
                mime = "application/java-archive";
                run = "ouch";
              }
              # Replace magick, image, video with mediainfo
              {
                mime = "{audio,video,image}/*";
                run = "mediainfo";
              }
              {
                mime = "application/subrip";
                run = "mediainfo";
              }

            ];
            prepend_preloaders = [
              # Replace magick, image, video with mediainfo
              {
                mime = "{audio,video,image}/*";
                run = "mediainfo";
              }
              {
                mime = "application/subrip";
                run = "mediainfo";
              }
            ];
            prepend_fetchers = [
              {
                url = "*";
                run = "git";
                group = "git";
              }
              {
                url = "*/";
                run = "git";
                group = "git";
              }
            ];
          };
        };
      };
    };
}
