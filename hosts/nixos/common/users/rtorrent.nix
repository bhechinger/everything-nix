{ pkgs, outputs, config, lib, ... }:
{
  imports = [
    ./media_group.nix
  ];

  users.groups.rtorrent = {};

  users.users = {
    rtorrent = {
      createHome = false;
      group = "rtorrent";
      extraGroups = [ "media" ];
    };

    rutorrent = {
      createHome = false;
      extraGroups = [ "media" ];
    };
  };
}
