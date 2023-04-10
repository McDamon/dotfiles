{ pkgs, config, inputs, ... }: {
  imports = [
    ./vscode.nix
  ];
  home.packages = [ inputs.devenv.packages.${pkgs.hostPlatform.system}.devenv ];
}
