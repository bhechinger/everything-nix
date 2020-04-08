{ pkgs, ... }: {
  home-manager.users.adrielus = {
    home.packages = with pkgs.gitAndTools; [ hub ];
    programs.git = {
      enable = true;

      userName = "Matei Adriel";
      userEmail = "rafaeladriel11@gmail.com";

      aliases = import ./aliases.nix;

      extraConfig = {
        github.user = "Mateiadrielrafael";
        hub.protocol = "ssh";

        rebase.autoStash = true;
      };
    };
  };
}
