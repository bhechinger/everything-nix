{ pkgs, outputs, config, lib, ... }:
{
  users.groups.media = {
    gid = 999;
  };
}
