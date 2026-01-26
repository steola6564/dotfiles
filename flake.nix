{
  description = "NixOS/Darwin unified repo (方案A)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    nix-darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    opencode = {
      url = "github:anomalyco/opencode";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nixpkgs, unstable, home-manager, agenix, vscode-extensions, nvfetcher, flake-utils, ... }:
  let
    systemOutputs = 
      flake-utils.lib.eachDefaultSystem (system:
        let
	  pkgs = import nixpkgs {
	    inherit system;
	    config.allowUnfree = true;
	  };
	in
        {
	  devshells = {
	  };

	  apps = {
	    nvfetcher = {
	      type = "app";
	      program = 
	        "${inputs.nvfetcher.packages.${system}.default}/bin/nvfetcher";
	    };
	  };
	}
      );
  in
  {
    inherit (systemOutputs) apps devShells;

    homeManagerModules = {
      default =
        { config, lib, pkgs, username, homeDirectory, ... }:
        {
          imports = [
            ./modules/home/home.nix
          ];

          home.username = username;
          home.homeDirectory = homeDirectory;
          home.stateVersion = "25.05";
        };
    };

    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos-desktop/configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };

    darwinConfigurations."darwin-air" = inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs;
        hostname = "darwin-air";
      };
      modules = [
        ./hosts/darwin-air/configuration.nix
        home-manager.darwinModules.home-manager
	({ pkgs, ... }: {
          nixpkgs.overlays = [
	    vscode-extensions.overlays.default
	  ];
	})
      ];
    };
  };
}

