{ pkgs, ... }:
let
  # config-nvim = "/etc/nixos/configuration/dotfiles/neovim";
  config-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "config-nvim";
    src = ../../dotfiles/neovim;
  };
in
{
  home-manager.users.adrielus.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    extraConfig = ''
      luafile ${config-nvim}/init.lua
    '';

    extraPackages = with pkgs; [
      # Language servers
      nodePackages.typescript-language-server # typescript
      easy-purescript-nix.purescript-language-server # purescript
      sumneko-lua-language-server # lua
      efm-langserver # auto-formatting
      rnix-lsp # nix

      # Formatters
      luaformatter # lua
      prettierd # prettier but faster

      # Others
      fd # file finder
      ripgrep # grep rewrite (I think?)
      nodePackages.typescript # typescript language
      texlive.combined.scheme-full # latex stuff
      python38Packages.pygments # required for latex syntax highlighting
    ];

    plugins = with pkgs.vimPlugins;
      with pkgs.vimExtraPlugins; [
        config-nvim # my neovim config
        github-nvim-theme # github theme for neovim
        nvim-lspconfig # configures lsps for me
        nvim-autopairs # close pairs for me
        telescope-nvim # fuzzy search for say opening files
        purescript-vim # purescript syntax highlighting
        nvim-comment # allows toggling line-comments
        nvim-treesitter # use treesitter for syntax highlighting
        startup-nvim # splash screen
        vim-devicons # nice looking icons
        nvim-web-devicons # fork of vim-devicons?
        plenary-nvim # async utility lib it seems?
        lualine-nvim # customizable status line
        nvim-tree-lua # file tree
        vimtex # latex plugin


        # Cmp related stuff. See https://github.com/hrsh7th/nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp
      ];
  };
}
