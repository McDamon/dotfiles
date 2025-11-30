{ ... }:
{
  # Used to find the project root
  projectRootFile = "flake.nix";

  programs = {
    nixfmt-rfc-style.enable = true;
    prettier.enable = true;
    shfmt = {
      enable = true;
      indent_size = 2;
    };
  };

  settings.formatter = {
    nixfmt-rfc-style = {
      excludes = [
        # Exclude hardware configuration (auto-generated)
        "**/hardware-configuration.nix"
      ];
    };
    
    prettier = {
      excludes = [
        # Don't format SOPS encrypted files
        "secrets/**/*.yaml"
      ];
    };
  };
}
