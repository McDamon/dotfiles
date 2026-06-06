# Shell for bootstrapping flake-enabled nix and other tooling
{ pkgs }:
{
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [
      age
      git
      gnupg
      home-manager
      just
      lshw
      nix
      nixfmt
      sbctl
      sops
      ssh-to-age
      treefmt
      wget
    ];
  };
}
