{ outputs, inputs }:
{
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (
      _: flake:
      let
        legacyPackages = ((flake.legacyPackages or { }).${final.system} or { });
        packages = ((flake.packages or { }).${final.system} or { });
      in
      if legacyPackages != { } then legacyPackages else packages
    ) inputs;
  };

  # Adds my custom packages
  additions =
    final: prev:
    import ../pkgs {
      pkgs = final;
    };

  # Modifies existing packages
  modifications = final: prev: {
    # cantarell-fonts 0.311 fails to build under afdko 5.0.1: otfautohint
    # crashes on Cantarell-VF.otf during the variable-font build. Autohinting
    # is a cosmetic rendering step, so make just that call non-fatal and let
    # the (unhinted) font build. Drop once nixpkgs ships a fixed afdko.
    cantarell-fonts = prev.cantarell-fonts.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        substituteInPlace scripts/make-variable-font.py \
          --replace-fail "subprocess.check_call(" "subprocess.call("
      '';
    });
  };
}
