{
  description = "the zlake";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    keep-outputs = true;
    keep-derivations = true;
  };

  inputs = {
    # nix
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    flake-utils.url = "github:numtide/flake-utils";
    #hm
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # other shit

    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    ghostty.url = "github:ghostty-org/ghostty";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      hyprland,
      ...
    }:
    let
      username = "zelda";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."kernel-linux-mckenzie" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = [
          { nixpkgs.config.allowUnfree = true; }
          ./configuration.nix
          { boot.kernelPackages = pkgs.linuxPackages_zen; }

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.${username} = import ./home.nix {
                pkgs = import nixpkgs {
                  inherit system;
                  config.allowUnfree = true;
                };
                inherit inputs;
                nixvim = inputs.nixvim;
                spicetify-nix = inputs.spicetify-nix;
                ghostty = inputs.ghostty;
                config = { };
              };
            };
          }
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.git
          pkgs.nixd
          pkgs.nixfmt-rfc-style
        ];
      };
    };
}
