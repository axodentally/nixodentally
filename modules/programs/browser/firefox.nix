{
  flake.modules.nixos.firefox =
    let
      lock-false = {
        Value = false;
        Status = "locked";
      };
      lock-true = {
        Value = true;
        Status = "locked";
      };
      lock-empty-string = {
        Value = "";
        Status = "locked";
      };
    in
    {
      programs.firefox = {
        enable = true;

        policies = {
          DontCheckDefaultBrowser = true;
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          DisplayBookmarksToolbar = "never";
          SearchBar = "unified";
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
            EmailTracking = true;
            SuspectedFingerprinting = true;
            BaselineExceptions = true;
            ConvenienceExceptions = false;
          };
          Homepage = {
            StartPage = "previous-session";
          };
          HttpsOnlyMode = "enabled";
          OfferToSaveLogins = false;
          SkipTermsOfUse = true;
          TranslateEnabled = true;

          Preferences = {
            "browser.newtabpage.pinned" = lock-empty-string;
            "browser.topsites.contile.enabled" = lock-false;
            "browser.newtabpage.activity-stream.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          };

          ExtensionSettings = {
            # bypass paywall clean
            "magnolia@12.34" = {
              install_url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-latest.xpi";
              installation_mode = "force_installed";
            };
            # Ublock origin
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # nice newpage
            "extension@tabliss-maintained" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/tablissng/latest.xpi";
              installation_mode = "force_installed";
            };
            # bitwarden
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
              installation_mode = "force_installed";
            };
            # treestyle tabs
            "treestyletab@piro.sakura.ne.jp" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
              installation_mode = "force_installed";
            };
            # colored TTS tabs
            "tst-colored-tabs@murz" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/tst-colored-tabs/latest.xpi";
              installation_mode = "force_installed";
            };
            # multiple tab handler for TTS
            "multipletab@piro.sakura.ne.jp" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/multiple-tab-handler/latest.xpi";
              installation_mode = "force_installed";
            };
            # I still don't care about cookies
            "idcac-pub@guus.ninja" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
              installation_mode = "force_installed";
            };
            # Old Reddit Redirect
            "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/old-reddit-redirect/latest.xpi";
              installation_mode = "force_installed";
            };
            # Refined Github
            "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/refined-github-/latest.xpi";
              installation_mode = "force_installed";
            };
            # Skip Redirect
            "skipredirect@sblask" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/skip-redirect/latest.xpi";
              installation_mode = "force_installed";
            };
            # Vimium
            "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
              installation_mode = "force_installed";
            };
            # Dark Reader
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "force_installed";
            };
            # # enable 1080p in netflix
            # # https://github.com/DavidBuchanan314/Turbo-Recadmiumator/issues/4#issuecomment-2021559752
            # "{5f1a672f-170c-4707-a73c-5512f04bf85e}" = {
            #   install_url = "https://github.com/DavidBuchanan314/Turbo-Recadmiumator/files/15093998/Turbo-Recadmiumator-firefox-6f3ad90e4653469ca4e5-0.0.1.zip";
            #   installation_mode = "force_installed";
            # };
          };
        };
      };

    };

  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    {
      programs = {
        firefox = {
          enable = true;
          profiles = {
            default = {
              id = 0;
              name = "axofox";
              isDefault = true;
              settings = {
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                "browser.tabs.drawInTitlebar" = true;
                "media.ffmpeg.vaapi.enabled" = true;
                # this is of no use currently
                # "image.jxl.enabled" = true;
              };
              search = {
                force = true;
                default = "google";
                order = [
                  "google"
                  "brave"
                ];
                engines = {
                  nix-packages = {
                    name = "Nix Packages";
                    urls = [
                      {
                        template = "https://search.nixos.org/packages";
                        params = [
                          {
                            name = "type";
                            value = "packages";
                          }
                          {
                            name = "query";
                            value = "{searchTerms}";
                          }
                        ];
                      }
                    ];

                    icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                    definedAliases = [ "@np" ];
                  };

                  nixos-wiki = {
                    name = "NixOS Wiki";
                    urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                    iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                    definedAliases = [ "@nw" ];
                  };
                  github-nixpkgs = {
                    name = "GitHub nixpkgs";
                    urls = [
                      { template = "https://github.com/NixOS/nixpkgs/issues?q=sort%3Aupdated-desc%20{searchTerms}"; }
                    ];
                    iconMapObj."16" = "https://github.com/favicon.ico";
                    definedAliases = [ "@npkg" ];
                  };
                  homemanager-options = {
                    name = "HomeManager Options";
                    urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
                    iconMapObj."16" = "https://home-manager-options.extranix.com/favicon.ico";
                    definedAliases = [ "@nhm" ];
                  };
                  # "brave" = {
                  #   urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
                  #   iconUpdateURL = "https://cdn.search.brave.com/serp/v2/_app/immutable/assets/favicon.acxxetWH.ico";
                  #   updateInterval = 24 * 60 * 60 * 1000; # every day
                  #   definedAliases = [ "br" ];

                  # };
                };
              };
              userChrome = ''
                 #main-window[tabsintitlebar="true"]:not([extradragspace="true"]) #TabsToolbar > .toolbar-items {
                   opacity: 0;
                   pointer-events: none;
                 }
                 #main-window:not([tabsintitlebar="true"]) #TabsToolbar {
                   visibility: collapse !important;
                 }
                 #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
                   display: none;
                 }
                 
                 #sidebar {
                   min-width: 100px !important;
                 }
                 
                 @-moz-document regexp("moz-extension://.+/resources/group-tab.html.*") {
                   :root {
                     background: darkgray !important;
                   }
                 }
                 
                 @media only screen and (max-width: 1300px) {
                   /*Collapse in default state and add transition*/
                   #sidebar-box {
                     overflow: hidden;
                     min-width: 40px !important;
                     max-width: 40px !important;
                     transition: all 0.3s ease;
                     border-right: 1px solid #0c0c0d;
                     z-index: 2;
                   }

                  /*Expand to 260px on hover*/
                  #sidebar-box:hover, #sidebar-box #sidebar {
                    min-width: 260px !important;
                    max-width: 260px !important;
                    z-index: 1;
                  }
                }
              '';
            };
          };
        };
      };
    };
}
