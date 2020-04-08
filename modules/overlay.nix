{ ... }:
let imports = import ../nix/sources.nix;
in {
  nixpkgs.overlays = [
    (self: super:
      with self; rec {
        inherit imports;
        cached-nix-shell = callPackage imports.cached-nix-shell { };
        inherit (import imports.niv { }) niv;
        inherit (import imports.all-hies { }) all-hies;
      })
  ];

  # allow packages with unfree licenses
  nixpkgs.config.allowUnfree = true;

  nix = {
    trustedUsers = [ "root" "adrielus" "@wheel" ];
    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;
    binaryCaches = [ "https://cache.nixos.org" "https://all-hies.cachix.org" ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];
  };
}
