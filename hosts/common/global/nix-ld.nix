{ nix-ld-rs }:
{
  programs.nix-ld = {
    enable = true;
    package = nix-ld-rs;
  };
}
