# Secrets Management with SOPS

## Setup

1. **Generate your age key** (if you don't have one):

   ```bash
   mkdir -p ~/.config/sops/age
   ssh-to-age < ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
   # Get public key
   ssh-to-age < ~/.ssh/id_ed25519.pub
   ```

2. **Update .sops.yaml** with your public age key

3. **Create secrets files**:

   ```bash
   # System secrets (available to NixOS)
   sops secrets/system/example.yaml

   # User secrets (available to home-manager)
   sops secrets/users/amcmahon.yaml
   ```

## Usage Examples

### In NixOS configuration:

```nix
{
  sops.secrets."wifi/password" = {
    sopsFile = ../../secrets/system/network.yaml;
  };

  networking.wireless.networks."MyNetwork".psk = config.sops.secrets."wifi/password".path;
}
```

### In home-manager:

```nix
{
  sops.secrets."github/token" = {
    sopsFile = ../../secrets/users/amcmahon.yaml;
  };

  programs.git.extraConfig.credential.helper =
    "store --file ${config.sops.secrets."github/token".path}";
}
```

## Secret File Format

```yaml
# secrets/system/example.yaml
wifi:
  password: "supersecret"
api_keys:
  openai: "sk-..."
```
