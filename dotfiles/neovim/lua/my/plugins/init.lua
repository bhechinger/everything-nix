local env = require("my.helpers.env")

if env.neovide.active() then
  require("my.neovide").setup()
end

return {
  --{{{ Language support
  {
    "purescript-contrib/purescript-vim",
    ft = "purescript",
    cond = env.vscode.not_active(),
  },

  {
    "teal-language/vim-teal",
    ft = "teal",
    cond = env.vscode.not_active(),
  },

  {
    "udalov/kotlin-vim",
    ft = "kotlin",
    cond = env.vscode.not_active(),
  },

  {
    "kmonad/kmonad-vim",
    ft = "kbd",
    cond = env.vscode.not_active(),
  },

  {
    "vmchale/dhall-vim",
    ft = "dhall",
    cond = env.vscode.not_active(),
  },
  --}}}

  {
    -- Better ui for inputs/selects
    "stevearc/dressing.nvim",
    config = true,
    -- https://github.com/folke/dot/blob/master/config/nvim/lua/config/plugins/init.lua
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    cond = env.vscode.not_active(),
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function ()
      require("nvim-autopairs").setup()
    end,
  },

  -- Helper libs
  {
    "nvim-lua/plenary.nvim",
  },

  "MunifTanjim/nui.nvim",

  {
    "terrortylor/nvim-comment",
    keys = { "gc", "gcc", { "gc", mode = "v" } },
    config = function()
      require("nvim_comment").setup()
    end,
  },

  -- nice looking icons
  "kyazdani42/nvim-web-devicons",

  {
    -- easly switch between tmux and vim panes
    "christoomey/vim-tmux-navigator",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
    cond = env.vscode.not_active()
      and env.neovide.not_active()
      and env.firenvim.not_active(),
  },

  {
    -- track time usage
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    cond = env.vscode.not_active() and env.firenvim.not_active(),
  },

  {
    -- smooth scrolling
    "psliwka/vim-smoothie",
    -- enabled = env.neovide.not_active(),
    enabled = false,
    event = "VeryLazy",
  },

  {
    -- show context on closing parenthesis
    -- TODO: move this to treesitter file
    "haringsrob/nvim_context_vt",
    event = "BufReadPost",
    cond = env.vscode.not_active(),
  },

  {
    -- show progress for lsp stuff
    "j-hui/fidget.nvim",
    event = "BufReadPre",
    cond = env.vscode.not_active(),
    config = true,
  },

  {
    -- export to pastebin like services
    "rktjmp/paperplanes.nvim",
    config = {
      provider = "paste.rs",
    },
    keys = { "PP" },
  },

  {
    -- case switching + the subvert command
    "tpope/vim-abolish",
    event = "VeryLazy",
  },

  {
    -- reminds you of abbreviations
    "0styx0/abbreinder.nvim",
    dependencies = "0styx0/abbremand.nvim",
    event = "InsertEnter",
  },

  {
    -- md preview (in terminal)
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    cond = env.vscode.not_active(),
  },

  {
    "frabjous/knap", -- md preview
    cond = env.vscode.not_active(),
  },

  {
    -- automatically set options based on current file
    "tpope/vim-sleuth",
    event = "BufRead",
    cond = env.vscode.not_active(),
  },

  -- vim-abolish rewrite
  "mateiadrielrafael/scrap.nvim",

  {
    "ruifm/gitlinker.nvim", -- generate permalinks for code
    -- dependencies = { "plenary.nvim" },
    config = true,
    cond = env.firenvim.not_active(),
    keys = "<leader>gy",
  },

  {
    -- magit clone
    "TimUntersberger/neogit",
    -- dependencies = { "plenary.nvim" },
    cmd = "Neogit",
    enabled = env.firenvim.not_active() and env.vscode.not_active(),
    init = function()
      vim.keymap.set(
        "n",
        "<C-g>",
        "<cmd>Neogit<cr>",
        { desc = "Open neo[g]it" }
      )
    end,
    config = true,
  },

  {
    -- discord rich presence
    "andweeb/presence.nvim",
    cond = env.vscode.not_active() and env.firenvim.not_active(),
    config = function()
      require("presence"):setup()
    end,
    lazy = false
  },
}
