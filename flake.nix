{
	description = "NixOS config!";

	inputs = {
		# NixOS official package source, using the nixos-25.05 branch here
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			# follows nixpkgs above so as to decrease download sizes!
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ nixpkgs, home-manager, ... }: {
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
				# Import the previous configuration.nix we used,
				# so the old configuration file still takes effect
					./configuration.nix

					# make home-manager as a module of nixos
					# so home-manager config will be deployed auomatically when rebuilding nixos
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.jeppe = import ./home.nix;
					}
				];
			};
		};
	};
}
