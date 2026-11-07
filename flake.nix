{
  description = "Hyprland config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      local-system:
      let
        pkgs = nixpkgs.legacyPackages.${local-system};

        # Extract only the stubs directory into a dedicated store path
        hyprland-stubs = pkgs.runCommandLocal "hyprland-stubs" { } ''
          mkdir -p $out
          cp -r ${pkgs.hyprland}/share/hypr/stubs/* $out/
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          name = "hypr-config";

          packages = with pkgs; [
            lua-language-server
          ];

          # Reference the isolated stubs store path directly
          HYPRLAND_STUBS = "${hyprland-stubs}";

          shellHook = ''
            # Dynamically generate .luarc.json pointing to the light stubs path
            cat << EOF > .luarc.json
            {
              "workspace": {
                "library": [
                  "${hyprland-stubs}"
                ]
              },
              "diagnostics": {
                "globals": ["hl"]
              }
            }
            EOF

            echo "LSP configuration generated using isolated Hyprland stubs."
          '';
        };
      }
    );
}
