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
    }:
    flake-utils.lib.eachDefaultSystem (
      local-system:
      let
        pkgs = nixpkgs.legacyPackages.${local-system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nixos-config";

          packages = with pkgs; [
            lua-language-server
          ];

          HYPRLAND_STUBS = "${pkgs.hyprland}/share/hypr/stubs";

          shellHook = ''
            # Dynamically generate .luarc.json pointing to the exact current nix package stubs
            cat << EOF > .luarc.json
            {
              "workspace": {
                "library": [
                  "${pkgs.hyprland}/share/hypr/stubs"
                ]
              },
              "diagnostics": {
                "globals": ["hl"]
              }
            }
            EOF

            echo "LSP configuration generated for this Hyprland version."
          '';
        };
      }
    );
}
