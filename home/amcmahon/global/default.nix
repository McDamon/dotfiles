{ inputs
, lib
, pkgs
, config
, outputs
, ...
}:
let
  inherit (inputs.nix-colors.lib-contrib { inherit pkgs; }) nixWallpaperFromScheme;
in
{
  imports =
    [
      inputs.nix-colors.homeManagerModule
      ../features/cli
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

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
    stateVersion = "23.11";

    sessionPath = [ "$HOME/.local/bin" ];
  };

  wallpaper =
    let
      largest = f: xs: builtins.head (builtins.sort (a: b: a > b) (map f xs));
      largestWidth = largest (x: x.width) config.monitors;
      largestHeight = largest (x: x.height) config.monitors;
    in
    lib.mkDefault (nixWallpaperFromScheme
      {
        scheme = config.colorscheme;
        width = largestWidth;
        height = largestHeight;
        logoScale = 4;
      });
}
