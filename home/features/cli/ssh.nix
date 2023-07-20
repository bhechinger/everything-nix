{ ... }: {
  programs.ssh.enable = true;

  # home.persistence = {
  #   "/persist/home/wonko".directories = [ ".ssh" ];
  # };
}
