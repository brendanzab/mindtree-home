{
  description = "mindtree's home-manager flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
    rust-overlay.url = "github:oxalica/rust-overlay/master";
  };
  outputs = inputs: let
    system = "x86_64-linux";
    env = import ./env/env.nix { inherit inputs; inherit system; };
  in {
    # Development environments.
    devShells.${system} = env.devShells;
    # Home configuration, pkgs, etc.
    nixosModule.imports = [
      env.devShellAliases
      ./default.nix
    ];
  };
}
