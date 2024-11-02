# Shell for bootstrapping flake-enabled nix and other tooling
{ pkgs }: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
    nativeBuildInputs = with pkgs; [
      age
      git
      gnupg
      home-manager
      lshw
      nix
      sbctl
      sops
      ssh-to-age
    ];
  };
}
