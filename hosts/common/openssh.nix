{
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PubkeyAuthentication = "yes";
      PubkeyAuthOptions = "verify-required";
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      PermitEmptyPasswords = false;
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
    };
  };

  users.users."amcmahon".openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJiE8XwKjtHZ7qaus5y4CbQn7+lsi3F5bI0wrCgWl/14" ];
}
