{
  imports = [
    ../common/global
    ../common/users/wonko.nix

    ../common/optional/pipewire.nix
    ../common/optional/xserver.nix
    ../common/optional/lightdm.nix
    ../common/optional/steam.nix
    ../common/optional/slambda.nix
    ../common/optional/xdg-portal.nix
    ../common/optional/hyprland.nix
    ../common/optional/gitea.nix
    ../common/optional/xmonad

    ./services/syncthing.nix
    ./hardware-configuration.nix
    ./boot.nix
  ];

  # Machine ids
  networking.hostName = "deepthought";
  environment.etc.machine-id.text = "08357db3540c4cd2b76d4bb7f825ec88";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";

  # {{{ A few ad-hoc hardware settings
  hardware.opengl.enable = true;
  hardware.opentabletdriver.enable = true;
  # }}}
  # {{{ A few ad-hoc programs
  programs.kdeconnect.enable = true;
  programs.extra-container.enable = true;
  # }}}
  # {{{ Ad-hoc stylix targets
  # TODO: include this on all gui hosts
  # TODO: is this useful outside of home-manager?
  stylix.targets.gtk.enable = true;
  # }}}
}
