{ pkgs, ... }:
{
  services.spotifyd = {
    enable = true;
    package = (pkgs.spotifyd.override { withKeyring = true; withMpris = true; withPulseAudio = true; });
    settings.global = {
      username_cmd = "${pkgs.coreutils}/bin/cat /home/amcmahon//.config/spotifyd.user";
      password_cmd = "${pkgs.coreutils}/bin/cat /home/amcmahon/.config/spotifyd.pass";
      use_mpris = true;
      dbus_type = "session";
      backend = "pulseaudio";
    };
  };
}
  
