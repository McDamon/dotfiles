{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
{
  imports = builtins.attrValues outputs.homeManagerModules;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      cudaSupport = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "amcmahon";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "26.05";

    sessionPath = [ "$HOME/.local/bin" ];

    shellAliases = {
      protontricks = "flatpak run com.github.Matoking.protontricks";
      protontricks-launch = "flatpak run --command=protontricks-launch com.github.Matoking.protontricks";
    };
  };
}
