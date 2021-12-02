{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      vi = "vim";
      trash = "gio trash";

      # cd.
      elmdir = "cd ~/programming/elm/";
      haskell = "cd ~/programming/haskell";
      idrisdir = "cd ~/programming/idris";
      jen = "cd ~/programming/rust/jen";
      rust = "cd ~/programming/rust/";
    };
  };
}
