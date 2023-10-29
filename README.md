[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# amcmahon NixOS configurations

NixOS/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

Shamelessly inspired/ripped-off from [misterio77](https://github.com/misterio77/nix-config).

Contains code from [K900](https://github.com/K900/vscode-remote-workaround)

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes devshells for boostrapping (`nix develop` or `nix-shell`).
- `hosts`: NixOS Configurations
  - `common`: Shared configurations consumed by the machine-specific ones.
    - `global`: Configurations that are globally applied to all machines.
    - `optional`: Opt-in configurations any machines can use.
  - `nixos-wsl`: WSL
  - `razorback`: Asus TUF A15 2023
- `home`: Home-manager configuration
- `modules`: Modules (with options).
- `overlay`: Patches and version overrides for some packages. Accessible via `nix build`.
- `pkgs`: Custom packages. Also accessible via `nix build`.

## How to bootstrap WSL

Add following to ```/etc/nixos/configuration.nix```

```
nix.settings.experimental-features = [ "nix-command" "flakes" ];

environment.systemPackages = with pkgs; [
  vim
  wget
  git
];
```

Then:

```
sudo nix-channel --add https://github.com/nix-community/NixOS-WSL/archive/refs/heads/main.tar.gz nixos-wsl
sudo nix-channel --update
```

```
cd ~/.config
git clone https://github.com/McDamon/dotfiles.git
cd dotfiles
sudo nixos-rebuild switch --flake .#nixos-wsl
home-manager switch --flake .#amcmahon@nixos-wsl
```
