{
  description = "mindtree's home-manager flake";
  inputs = {
    mindtree-home = {
      url = "./";
      flake = false;
    };
  };
  outputs = inputs: {
    nixosModule.imports = [ "${inputs.mindtree-home}/default.nix" ];
  };
}
