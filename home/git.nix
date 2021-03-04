{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "mitchmindtree";
    userEmail = "mail@mitchellnordine.com";
  };
}
