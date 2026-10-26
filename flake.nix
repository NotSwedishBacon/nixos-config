{
  description = "Multi-Host Dendritic NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    # Optional helper, not strictly required if we manually import or write a small helper
    # import-tree.url = "github:vic/import-tree";

    wrappers = {
      url = "github:nix-community/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [
        # You could use import-tree here, but for clarity we map manually
      ];

      flake = {
        nixosConfigurations = {
          host-alpha = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/host-alpha
              ./modules/core
              ./modules/programs
            ];
          };

          host-beta = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
              ./hosts/host-beta
              ./modules/core
              ./modules/programs
            ];
          };
        };
      };

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Export wrapped packages so they can be run standalone
        # e.g., nix run .#firefox
        packages = {
          firefox = (nixpkgs.lib.evalModules {
            modules = [
              inputs.wrappers.nixosModules.default
              ./modules/programs/firefox.nix
              {
                # Provide dummy values to evaluate standalone
                mySystem.programs.firefox.enable = true;
                _module.args = { inherit pkgs inputs; };
              }
            ];
          }).config.wrappers.firefox.wrappedPackage;

          htop = (nixpkgs.lib.evalModules {
            modules = [
              inputs.wrappers.nixosModules.default
              ./modules/programs/htop.nix
              {
                mySystem.programs.htop.enable = true;
                _module.args = { inherit pkgs inputs; };
              }
            ];
          }).config.wrappers.htop.wrappedPackage;

          ripgrep = (nixpkgs.lib.evalModules {
            modules = [
              inputs.wrappers.nixosModules.default
              ./modules/programs/ripgrep.nix
              {
                mySystem.programs.ripgrep.enable = true;
                _module.args = { inherit pkgs inputs; };
              }
            ];
          }).config.wrappers.rg.wrappedPackage;
        };
      };
    };
}
