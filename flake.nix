# /etc/nixos/flake.nix
{
  description = "Meu Setup Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    ashell.url = "github:MalpenZibo/ashell";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
      	inherit inputs;
      	inherit home-manager;
      };
      
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.jamesislan = import ./home.nix;
        }
      ];
    };
  };
}
