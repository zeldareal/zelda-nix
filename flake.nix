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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    textfox.url = "github:adriankarlen/textfox";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };   

  outputs = inputs@{ self, nixpkgs, home-manager, textfox, nixvim, spicetify-nix, ... }: 
    let
      username = "zelda";
    in
    {
      nixosConfigurations."kernel-linux-mckenzie" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username textfox nixvim; };
        modules = [
          { nixpkgs.config.allowUnfree = true; }
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit textfox nixvim spicetify-nix; };
            };
          }
        ];
      };

      devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
          git
          nixd
          nixfmt-rfc-style
        ];
      };
    };
}