-- Auto-completion engine
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter" },
  dependencies = {
    "onsails/lspkind.nvim", -- vscode-like pictograms
	  "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
	  "hrsh7th/cmp-buffer", -- buffer auto-completion
	  "hrsh7th/cmp-path", -- path auto-completion
	  "hrsh7th/cmp-cmdline", -- cmdline auto-completion
	  "L3MON4D3/LuaSnip", -- Code snippet engine
	  "saadparwaiz1/cmp_luasnip", -- for autocompletion
	  "rafamadriz/friendly-snippets", -- useful snippets
  },

  config = function()

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({

      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },

      snippet = {
        -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        -- Use <C-k/j> to switch in items
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        -- Use <C-b/f> to scroll the docs
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window

        -- Use <CR>(Enter) to confirm selection
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      }),

      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- For nvim-lsp
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),

      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

    })
  end,
}
