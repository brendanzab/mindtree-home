{ config, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./conf.vim;
    plugins = with pkgs.vimPlugins; [
      elm-vim
      idris-vim
      nerdtree
      rust-vim
      syntastic
      vim-glsl
      vim-nix
      vim-spirv
      vim-toml
    ];
  };
}
