[![built with nix](https://img.shields.io/static/v1?logo=nixos&logoColor=white&label=&message=Built%20with%20Nix&color=41439a)](https://builtwithnix.org)

# amcmahon NixOS configurations

NixOS/home-manager config files. Requires [Nix flakes](https://nixos.wiki/wiki/Flakes).

Shamelessly inspired/ripped-off from <https://github.com/misterio77/nix-config>

Contains some derivations from <https://github.com/fufexan/nix-gaming>

## Structure

- `flake.nix`: Entrypoint for hosts and home configurations. Also exposes a
  devshell for boostrapping (`nix develop` or `nix-shell`).
- `hosts`: NixOS Configurations
  - `common`: Shared configurations consumed by the machine-specific ones.
    - `global`: Configurations that are globally applied to all machines.
    - `optional`: Opt-in configurations any machines can use.
  - `merovingian`: Dell Precision 5560
  - `persephone`: Ryzen 5950X desktop
- `home`: Home-manager configuration
- `modules`: Modules (with options).
- `overlay`: Patches and version overrides for some packages. Accessible via `nix build`.
- `pkgs`: Custom packages. Also accessible via `nix build`.
- `templates`: A couple project templates for different languages. Accessible
  via `nix init`.

## How to bootstrap

All you need is nix (any version). Run:

```
nix-shell
```

If you already have nix 2.4+, git, and have already enabled `flakes` and
`nix-command`, you can also use the non-legacy command:

```
nix develop
```

`sudo nixos-rebuild switch --flake .#<hostname>` To build system configurations

`home-manager switch --flake .#amcmahon@<hostname>` To build user configurations

`nix build` (or shell or run) To build and use packages
