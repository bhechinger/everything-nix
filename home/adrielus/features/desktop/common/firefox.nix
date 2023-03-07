{ pkgs, inputs, ... }:
let
  mkBasicSearchEngine = { aliases, url, param }: {
    urls = [{
      template = url;
      params = [
        { name = param; value = "{searchTerms}"; }
      ];
    }];

    definedAliases = aliases;
  };

  mkNixPackagesEngine = { aliases, type }:
    let basicEngine = mkBasicSearchEngine
      {
        aliases = aliases;
        url = "https://search.nixos.org/${type}";
        param = "query";
      };
    in
    basicEngine // {
      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
    };
in
{
  programs.firefox = {
    enable = true;
    profiles.adrielus = {
      # Unique user id
      id = 0;

      # Make this the default user
      isDefault = true;

      # Forcefully replace the search configuration 
      search.force = true;

      # Set default search engine
      search.default = "Google";

      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        bypass-paywalls-clean
        clearurls # removes ugly args from urls
        firenvim # summon a nvim instance inside the browser
        gesturefy # mouse gestures
        localcdn # caches libraries locally
        lovely-forks # displays forks on github
        octolinker # github import to link thingy
        octotree # github file tree
        privacy-badger # blocks some trackers
        privacy-pass # captcha stuff
        return-youtube-dislikes
        ublock-origin # ad blocker
        vimium-c # vim keybinds
        sponsorblock # skip youtube sponsors
        translate-web-pages
      ];

      # Specify custom search engines
      search.engines = {
        "Nix Packages" = mkNixPackagesEngine {
          aliases = [ "@np" "@nix-packages" ];
          type = "packages";
        };

        "Nix options" = mkNixPackagesEngine {
          aliases = [ "@no" "@nix-options" ];
          type = "options";
        };

        # Purescript packages
        "Pursuit" = mkBasicSearchEngine {
          url = "https://pursuit.purescript.org/search";
          param = "q";
          aliases = [ "@ps" "@pursuit" ];
        };

        "Wikipedia" = mkBasicSearchEngine {
          url = "https://en.wikipedia.org/wiki/Special:Search";
          param = "search";
          aliases = [ "@wk" "@wikipedia" ];
        };

        "Github" = mkBasicSearchEngine {
          url = "https://github.com/search";
          param = "q";
          aliases = [ "@gh" "@github" ];
        };

        "Youtube" = mkBasicSearchEngine {
          url = "https://www.youtube.com/results";
          param = "search_query";
          aliases = [ "@yt" "@youtube" ];
        };

        "Noita wiki" = mkBasicSearchEngine {
          url = "https://noita.wiki.gg/index.php";
          param = "search";
          aliases = [ "@noita" ];
        };

        "Rain world wiki" = mkBasicSearchEngine {
          url = "https://rainworld.miraheze.org/w/index.php";
          param = "search";
          aliases = [ "@rw" "@rain-world" ];
        };

        "Factorio wiki" = mkBasicSearchEngine {
          url = "https://wiki.factorio.com/index.php";
          param = "search";
          aliases = [ "@fw" "@factorio-wiki" ];
        };

        "Factorio mod portal" = mkBasicSearchEngine {
          url = "https://mods.factorio.com/";
          param = "query";
          aliases = [ "@fm" "@factorio-mods" ];
        };

        "Google".metaData.alias = "@g";
      };
    };
  };

  firefox.apps.asana = {
    url = "https://app.asana.com/";
    icon = ./icons/asana.png;
    displayName = "Asana";
    id = 1;
  };

}
