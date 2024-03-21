{ outputs, inputs }:
{
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs
      (_: flake:
        let
          legacyPackages = ((flake.legacyPackages or { }).${final.system} or { });
          packages = ((flake.packages or { }).${final.system} or { });
        in
        if legacyPackages != { } then legacyPackages else packages
      )
      inputs;
  };

  # Adds my custom packages
  additions = final: prev: import ../pkgs { pkgs = final; };

  # Modifies existing packages
  modifications = final: prev: {
    waybar = prev.waybar.override {
      wireplumber = prev.wireplumber.overrideAttrs rec {
        version = "0.4.17";
        src = prev.fetchFromGitHub {
          owner = "pipewire";
          repo = "wireplumber";
          rev = version;
          sha256 = "sha256-vhpQT67+849WV1SFthQdUeFnYe/okudTQJoL3y+wXwI=";
        };
      };
    };
  };
}
