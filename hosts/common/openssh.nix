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
}
