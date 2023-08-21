{ pkgs, inputs, config, ... }: {
  imports = [ ./global ];

  # Arbitrary extra packages
  home.packages = [
    # Clis
    inputs.agenix.packages.${pkgs.system}.agenix # Secret encryption
  ];

  # Set up my custom imperanence wrapper
  satellite.persistence = {
    enable = true;

    # Actual data/media (eg: projects, images, videos, etc)
    at.data.path = "${config.home.homeDirectory}/.persist/data";

    # App state I want to keep
    at.state.path = "${config.home.homeDirectory}/.persist/state";

    # App state which I should be able to delete at any point
    at.cache.path = "${config.home.homeDirectory}/.persist/local/cache";
  };
}
