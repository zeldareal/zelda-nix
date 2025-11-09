
{
  description = "the zlake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    keep-outputs = true;
    keep-derivations = true;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    textfox.url = "github:adriankarlen/textfox";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    ghostty.url = "github:ghostty-org/ghostty";

    claude-desktop = {
      url = "github:k3d3/claude-desktop-linux-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ghostty, home-manager, textfox, nixvim, spicetify-nix, ... }:
    let
      username = "zelda";
      system = "x86_64-linux";
    in {
      nixosConfigurations."kernel-linux-mckenzie" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username textfox nixvim; };
        modules = [
          { nixpkgs.config.allowUnfree = true; }
          ./configuration.nix
          { boot.kernelPackages = inputs.nixpkgs.legacyPackages.${system}.linuxPackages_zen; }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home.nix;                                                                        backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs textfox nixvim spicetify-nix; };
            };
          }
        ];
      };

      devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
        buildInputs = with nixpkgs.legacyPackages.${system}; [
          git
          nixd
          nixfmt-rfc-style
        ];
      };
    };
}
