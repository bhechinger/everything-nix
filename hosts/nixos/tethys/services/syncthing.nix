{
  imports = [ ../../common/optional/syncthing.nix ];

  services.syncthing.folders = {
    "stellar-sanctum" = {
      path = "/home/wonko/Projects/stellar-sanctum/";
      devices = [ "enceladus" "newbob" ];

      # TODO: remove this once I switch to zfs
      versioning = {
        type = "staggered";
        params = {
          cleanInterval = "3600"; # 1 hour in seconds
          maxAge = "604800"; # 14 days in seconds.
        };
      };
    };
  };
}
