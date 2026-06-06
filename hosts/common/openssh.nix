{
  services.openssh = {
    enable = true;
    settings = {
      # Harden. verify-required enforces user verification for security-key auth.
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
