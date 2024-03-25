local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "neovim/nvim-lspconfig",
    {
        "ibhagwan/fzf-lua",
        keys = {
            {"<leader>p", "<cmd>lua require('fzf-lua').files()<CR>"},
            {"<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>"},
            {"<leader>/", "<cmd>lua require('fzf-lua').live_grep()<CR>"},
            {"<leader>.", "<cmd>lua require('fzf-lua').live_grep_resume()<CR>"},
            {"<leader>t", "<cmd>lua require('fzf-lua').tabs()<CR>"},
        },
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            {"<leader>gb", ":Git blame<CR>", silent = true},
            {"<leader>gd", ":Gvdiffsplit<CR>", silent = true},
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
        },
    },
    {
        "jacoborus/tender.vim",
        lazy = false,
        priority = 1000,
        config = function() vim.cmd([[colorscheme tender]]) end,
    },
}, {
    ui = {
        -- disable the default keybindings from lazy.nvim
        custom_keys = {
            ["<localleader>l"] = false,
            ["<localleader>t"] = false,
        },
    },
})

--[[
require("lspconfig").pyright.setup({})
require("lspconfig").ruff_lsp.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
    end,
})
--]]
require("lspconfig").pylsp.setup({
    settings = {
        pylsp = {
          plugins = {
              flake8      = { enabled = false },
              pycodestyle = { enabled = false },
              mccabe      = { enabled = false },
              pyflakes    = { enabled = false },
              yapf        = { enabled = false },
              black       = { enabled = false },
              isort       = { enabled = false },
              mypy        = { enabled = true  },
              ruff        = {
                  enabled = true,
                  format = { 
                      "I",      -- sort imports
                      "F401",   -- remove unused imports
                      "ICN001", -- unconvential import alias
                      "TID252", -- No relative imports from parent module
                  },
              },
          },
      },
    },
})
--]]

require("lspconfig").rust_analyzer.setup({})
require("lspconfig").gopls.setup({})
require("lspconfig").yamlls.setup({})

local cmp = require('cmp')
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        -- confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
	      if not entry then
	        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	      else
	        cmp.confirm()
	      end
        else
          fallback()
        end
      end, {"i","s"}),
    }),
    sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
	}, {
		{ name = "buffer", keyword_length = 3 },
	}),
    enabled = function()
      -- disable completion in comments
      if require('cmp.config.context').in_treesitter_capture('comment') == true
        or require('cmp.config.context').in_syntax_group('Comment') then
        return false
      else
        return true
      end
    end,

    experimental = {
        ghost_text = true,
    },
})
