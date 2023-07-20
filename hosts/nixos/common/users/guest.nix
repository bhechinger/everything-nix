# For more comments check out [wonko](./wonko.nix)
{ pkgs, outputs, lib, ... }:
{
  users.mutableUsers = false;
  users.users.guest = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "audio" "video" "network" "tty" ];
    password = "heyo";
    openssh.authorizedKeys.keyFiles =
      (import ./common.nix).authorizedKeys { inherit outputs lib; };
  };
}
