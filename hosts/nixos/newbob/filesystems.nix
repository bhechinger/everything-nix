# Mark a bunch of paths as needed for boot
{ lib, ... }:
{
  fileSystems = lib.attrsets.genAttrs
    [ "/" "/nix" "/persist/data" "/persist/state" "/persist/local/cache" "/boot" ]
    (_: { neededForBoot = true; });

  fileSystems."/nfs/Plex" = {
    device = "basket.4amlunch.net:/Plex";
    fsType = "nfs";
    options = [ "x-systemd.automount" "x-systemd.after=network-online.target" "x-systemd.mount-timeout=90" ];
  };

  fileSystems."/nfs/Torrents" = {
    device = "basket.4amlunch.net:/Torrents";
    fsType = "nfs";
    options = [ "x-systemd.automount" "x-systemd.after=network-online.target" "x-systemd.mount-timeout=90" ];
  };
}
