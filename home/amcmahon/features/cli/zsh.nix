{ config, ... }:
{
  programs.zsh = {
    enable = true;
    initExtra = "bindkey -v
      bindkey '^R' history-incremental-search-backward
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    shellAliases = {
      nixos-rebuild-switch = "sudo nixos-rebuild switch --flake .#merovingian";
      home-manager-switch = "home-manager switch --flake .#amcmahon@merovingian";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };
}
