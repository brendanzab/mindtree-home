# mindtree home-manager configuration.
{ config, lib, pkgs, ... }: {
  imports = [
    # Command-line interface stuff.
    ./home/cli.nix
    # Desktop-environment stuff.
    ./home/de.nix
  ];
  nixpkgs.config = {
    permittedInsecurePackages =
      lib.lists.optional config.mindtree.de.enable config.mindtree.de.permittedInsecurePkgNames;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg)
      (config.mindtree.cli.unfreePkgNames
        ++ lib.lists.optional config.mindtree.de.enable config.mindtree.de.unfreePkgNames);
  };
}
