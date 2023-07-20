{ pkgs, outputs, config, lib, ... }:
{
  # Password file stored through agenix
  age.secrets.wonkoPassword.file = ./wonko_password.age;

  users = {
    # Configure users through nix only
    mutableUsers = false;

    # Create an user named wonko
    users.wonko = {
      # Adds me to some default groups, and creates the home dir 
      isNormalUser = true;

      # File containing my password, managed by agenix
      passwordFile = config.age.secrets.wonkoPassword.path;

      # Set default shell
      shell = pkgs.fish;

      # Add user to the following groups
      extraGroups = [
        "wheel" # Access to sudo
        "lp" # Printers
        "audio" # Audio devices
        "video" # Webcam and the like
        "network" # wpa_supplicant
#        "syncthing" # syncthing!
      ];

      openssh.authorizedKeys.keyFiles =
        (import ./common.nix).authorizedKeys { inherit outputs lib; };
    };
  };
}
