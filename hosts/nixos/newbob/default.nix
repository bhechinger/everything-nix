{
  imports = [
    ../common/global
    ../common/users/wonko.nix
#    ../common/optional/slambda.nix

#    ./services/syncthing.nix
    ./hardware-configuration.nix
    ./filesystems.nix
    ./zfs.nix

    (import ./partitions.nix {
      disks = [ "/dev/vda" ];
    })
  ];

  # Machine ids
  networking = {
    hostName = "newbob";
    hostId = "3f3fb897";
    domain = "4amlunch.net";
    dhcpcd.enable = false;
    interfaces.enp1s0.ipv4.addresses = [{
      address = "10.42.11.99";
      prefixLength = 24;
    }];
    vlans = {
      external = { id=100; interface="enp1s0"; };
      internal = { id=420; interface="enp1s0"; };
      guest = { id=410; interface="enp1s0"; };
    };
    interfaces.internal.ipv4.addresses = [{
      address = "10.42.0.99";
      prefixLength = 24;
    }];
    defaultGateway = "10.42.0.1";
    nameservers = [ "10.42.0.2" "10.42.0.10" "10.42.0.12" ];

    firewall.enable = false; # I will look into this later
  };

  environment.etc.machine-id.text = "d9571439c8a34e34b89727b73bad3587";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  # Bootloader
  boot.loader.systemd-boot.enable = true;

  boot.zfs.devNodes = "/dev/disk/by-path/pci-0000:07:00.0-part2";
}
