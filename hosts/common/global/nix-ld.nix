{ pkgs, nix-ld-rs ? null }:
let 
  nix-ld-rs' = if nix-ld-rs != null then nix-ld-rs else pkgs.nix-ld-rs;
in 
{
  programs.nix-ld = {
    enable = true;
    package = nix-ld-rs';
  };
}
