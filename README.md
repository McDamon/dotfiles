# dotfiles
Andrew McMahon's NixOS dotfiles
[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# amcmahon NixOS configurations

NixOS/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

Shamelessly inspired/ripped-off from [misterio77](https://github.com/misterio77/nix-config) and [archer-65](https://github.com/archer-65/nix-dotfiles)

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes devshells for boostrapping (`nix develop` or `nix-shell`).
- `hosts`: NixOS Configurations
  - `common`: Shared configurations consumed by the machine-specific ones.
    - `common`: Configurations that are applied to all machines.
    - `optional`: Opt-in configurations any machines can use.
  - `razorback`: Asus TUF A17 2023 Laptop
- `home`: Home-manager configuration
- `modules`: Modules (with options).
- `overlays`: Patches and version overrides for some packages. Accessible via `nix build`.
- `pkgs`: Custom packages. Also accessible via `nix build`.

## How to bootstrap

Using `razorback as an example:

Add following to ```/etc/nixos/configuration.nix```

```nix
networking.hostName = "razorback";

nix.settings.experimental-features = [ "nix-command" "flakes" ];

environment.systemPackages = with pkgs; [
  vim
  wget
  git
];
```

Then:

```bash
cd ~/.config
git clone https://github.com/McDamon/dotfiles.git
cd dotfiles
nix develop
sudo nixos-rebuild switch --flake .#razorback
home-manager switch --flake .#amcmahon@razorback
```
