{ lib
, ...
}:
{
  systemd.user.services.waybar = {
    Unit = {
      # Let it try to start a few more times
      StartLimitBurst = 30;
      # Reload instead of restarting
      X-Restart-Triggers = lib.mkForce [ ];
      X-SwitchMethod = "reload";
    };
  };
  
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      primary = {
        exclusive = false;
        passthrough = false;
        height = 40;
        margin = "6";
        position = "top";
      };
    };
  };
}
