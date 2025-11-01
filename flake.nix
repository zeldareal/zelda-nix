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
    nixvim = {
  url= "github:nix-community/nixvim";
  inputs.nixpkgs.follows = "nixpkgs";
};
  };


  outputs = inputs@{ self, nixpkgs, home-manager, textfox, nixvim, ... }: let
    system = "x86_64-linux";
    username = "zelda";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
      nixosConfigurations."kernel-linux-mckenzie" = nixpkgs.lib.nixosSystem {

      inherit system;
      specialArgs = { inherit inputs system username textfox nixvim; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit textfox nixvim; };
          };
        }

       
      ];
    };

    
    # optional dev shell (great for working with Nix)
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        git
        nixd
        nixfmt-rfc-style
      ];
    };
  };
}
