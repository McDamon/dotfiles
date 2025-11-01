{ ... }:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "amcmahon" ];
  };

  # Enable the 1Password browser extension communication
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
        brave
        firefox
        chromium
      '';
      mode = "0644";
    };
  };
}
