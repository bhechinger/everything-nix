let
  tethys = builtins.readFile ./hosts/nixos/tethys/ssh_host_ed25519_key.pub;
  newbob = builtins.readFile ./hosts/nixos/newbob/ssh_host_ed25519_key.pub;

  wonko_tethys = builtins.readFile ./hosts/nixos/tethys/id_ed25519.pub;
  wonko_newbob = builtins.readFile ./hosts/nixos/newbob/id_ed25519.pub;

  all_hosts = [ tethys newbob ];
in
{
  # Scoped for entire systems
  "./hosts/nixos/common/global/wireless/wifi_passwords.age".publicKeys = all_hosts ++ [ wonko_tethys ];
  "./hosts/nixos/common/users/wonko_password.age".publicKeys = all_hosts ++ [ wonko_tethys ];

  # Scoped for the user
  # TODO: move this into `pass`.
  "./home/features/desktop/wakatime/wakatime_config.age".publicKeys = [ wonko_tethys ];
}
