# Mark a bunch of paths as needed for boot
{ lib, ... }:
{
  fileSystems."/" = {
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    neededForBoot = true;
  };

  fileSystems."/persist/data" = {
    neededForBoot = true;
  };

  fileSystems."/persist/state" = {
    neededForBoot = true;
  };

  fileSystems."/persist/local/cache" = {
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    neededForBoot = true;
  };

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
