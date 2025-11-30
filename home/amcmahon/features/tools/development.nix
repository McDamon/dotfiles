{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Development Tools
    ansible
    age
    gh
    git
    nil # Nix LSP
    nixpkgs-fmt
    lunarvim
    neovim
    vim

    # Cloud & Infrastructure
    fluxcd
    kubectl
    kubernetes-helm
    kompose
    kubeconform
    kustomize
    minio-client
    terraform

    # Secrets & Security
    sops
    ssh-to-age
    tpm2-tss
  ];
}
