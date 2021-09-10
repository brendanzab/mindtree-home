{ config, pkgs, ... }:
{
  programs.vim =
    let
      wgsl-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "wgsl-vim";
        version = "2021-09-11";
        src = pkgs.fetchFromGitHub {
          owner = "dingdean";
          repo = "wgsl.vim";
          rev = "cb0f33e9a9040577d33daba569e3e8ed1041837d";
          sha256 = "1hwj5gbd7w52vzaw5bk1p1l7c50zb9l9psyijgv2jd6wsgancd8x";
        };
        meta.homepage = "https://github.com/dingdean/wgsl.vim/";
      };
    in {
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
        wgsl-vim
      ];
    };
}
