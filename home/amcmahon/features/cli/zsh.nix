{ config, ... }:
let
  configThemeNormal = ./p10k.zsh;
in
{
  programs.zsh = {
    enable = true;
    initExtra = ''
      [[ ! -f ${configThemeNormal} ]] || source ${configThemeNormal}
    '';
    shellAliases = {
      nixos-rebuild-switch = "sudo nixos-rebuild switch --flake .#${builtins.getEnv "HOSTNAME"}";
      home-manager-switch = "home-manager switch --flake .";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
