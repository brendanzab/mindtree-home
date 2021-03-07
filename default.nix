# mindtree home-manager configuration.
{ config, lib, pkgs, ... }: {
  imports = [
    # Command-line interface stuff.
    ./home/cli.nix
    # Desktop-environment stuff.
    ./home/de.nix
  ];

  nixpkgs.config = {
    permittedInsecurePackages = if config.mindtree.de.enable then
      config.mindtree.de.permittedInsecurePkgNames
    else
      [ ];
    allowUnfreePredicate = let
      unfreeCliPkgNames = config.mindtree.cli.unfreePkgNames;
      unfreeDePkgNames = if config.mindtree.de.enable then
        config.mindtree.de.unfreePkgNames
      else
        [ ];
      unfreePkgNames = unfreeCliPkgNames ++ unfreeDePkgNames;
    in pkg: builtins.elem (lib.getName pkg) unfreePkgNames;
  };
}
