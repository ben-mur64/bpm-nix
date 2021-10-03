# flake.nix -- The first file that gets loaded
#
# Author:  Benjamin Murray <murraybp64@gmail.com>
# URL:     https://github.com/bpm-elite/bpm-nix
# License: https://github.com/bpm-elite/bpm-nix
#
# This file loads all of the modules and sets up the flake.

{
  description = "All 4 (eventually) of my system configurations.";

  inputs =
    {
      # Core dependencies
      nixos.url = "github:nixos/nixpkgs/nixos-unstable";
      nixpkgs.url = "nixpkgs/nixos-unstable";
      nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";
      home.url = "github:rycee/home-manager/master";
      home.inputs.nixpkgs.follows = "nixpkgs";

      # Overlays and such
      emacs-overlay.url = "github:nix-community/emacs-overlay";
    };
  outputs =
    { self,
      nixos,
      nixpkgs,
      nixpkgs-unstable,
      home,
      emacs-overlay,
      ... } @ inputs:
    {
      nixosConfigurations = {
        lappy-486 = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./systems/lappy/configuration.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };
  };
}
