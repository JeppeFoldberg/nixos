{
  description = "My first simple NixOS flake!";

  inputs = {
    nixpgks.url = "github:NixOS/nixpgks/nixos-23.11";
  };
  
  outputs = { self, nixpgks, ... }@inputs: {
    nixosConfigurations.nixos = nixpgks.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
