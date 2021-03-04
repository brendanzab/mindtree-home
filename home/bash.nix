{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      vi = "vim";
      trash = "gio trash";
      idris-dev = "cd ~/programming/idris/ && nix-shell";

      # cd.
      elmdir = "cd ~/programming/elm/";
      haskell = "cd ~/programming/haskell";
      idrisdir = "cd ~/programming/idris";
      jen = "cd ~/programming/rust/jen";
      rust = "cd ~/programming/rust/";
    };
  };
}
